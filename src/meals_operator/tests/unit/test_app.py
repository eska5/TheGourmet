import pytest
import os
from app import app
import meal_operator as m_operator


@pytest.fixture
def client():
    app.config["TESTING"] = True

    with app.app_context():
        with app.test_client() as client:
            yield client


def test_app_health_check(client):
    resp = client.get("/ping")
    assert resp.status_code == 200
    assert str(resp.data)[2:-1] == "App is running."
    assert resp.content_type == "application/json"


def test_suggestions(client, mocker):
    json_dumps_mock = mocker.patch("app.json.dumps")
    get_suggestions_mock = mocker.patch("app.m_operator.get_suggestions")
    resp = client.get("/suggestions")
    get_suggestions_mock.assert_called_once()
    json_dumps_mock.assert_called_once()
    assert resp.status_code == 200
    assert resp.content_type == "application/json"


def test_meals_success(client, mocker):
    example_name = "potato"
    example_photo = "potato_photo.jpg"
    save_image_mock = mocker.patch("app.m_operator.save_image")
    resp = client.post(
        "/meals", json={"mealName": example_name, "mealPhoto": example_photo}
    )
    assert resp.status_code == 201
    save_image_mock.assert_called_once_with(
        title=example_name, coded_image=example_photo, path=m_operator.NEW_IMAGES_PATH
    )


def test_meals_fail(client):
    example_name = ""
    example_photo = ""
    resp = client.post(
        "/meals", json={"mealName": example_name, "mealPhoto": example_photo}
    )
    assert resp.status_code == 400


def test_meals_fail_key_error(client):
    resp = client.post("/meals", json={"data": "example_data"})
    assert resp.status_code == 400


def test_bad_result(client, mocker):
    example_correct_name = "potato"
    example_bad_name = "banana"
    example_photo = "potato_photo.jpg"
    mock_bad_result_name = f"{example_bad_name}_{example_correct_name}"
    save_image_mock = mocker.patch("app.m_operator.save_image")
    resp = client.post(
        "/badresult",
        json={
            "useroutput": example_correct_name,
            "modeloutput": example_bad_name,
            "mealPhoto": example_photo,
        },
    )
    assert resp.status_code == 201
    save_image_mock.assert_called_once_with(
        title=mock_bad_result_name,
        coded_image=example_photo,
        path=m_operator.BAD_RESULTS_PATH,
    )


def test_bad_result_fail_key_error(client):
    resp = client.post("/badresult", json={"data": "example_data"})
    assert resp.status_code == 400


def test_bad_result_fail(client):
    example_correct_name = ""
    example_bad_name = ""
    example_photo = "potato_photo.jpg"
    resp = client.post(
        "/badresult",
        json={
            "useroutput": example_correct_name,
            "modeloutput": example_bad_name,
            "mealPhoto": example_photo,
        },
    )
    assert resp.status_code == 400


def test_meal_details(client, mocker):
    example_name = "pizza"
    json_dumps_mock = mocker.patch("app.json.dumps")
    get_meal_mock = mocker.patch("app.m_operator.get_meal")
    resp = client.get("/details", query_string={"name": example_name})
    get_meal_mock.assert_called_once_with(meal_name=example_name)
    json_dumps_mock.assert_called_once()
    assert resp.status_code == 200
    assert resp.content_type == "application/json"


def test_meal_details_fail(client):
    resp = client.get("/details")
    assert resp.status_code == 404
