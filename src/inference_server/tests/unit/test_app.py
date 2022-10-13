# pylint: disable=W0621
import pytest
from app import app


@pytest.fixture
def test_client(mocker):
    app.config["TESTING"] = True
    mocker.patch("app.load_model_to_memory")
    with app.app_context():
        with app.test_client() as flask_client:
            yield flask_client


def test_ping(test_client):
    resp = test_client.get("/ping")
    assert resp.status_code == 200
    assert resp.text == f"App is running."


def test_catalog(test_client, mocker):
    catalog_mock = ["tomato", "potato", "pizza"]
    meals_data_mock = mocker.patch(
        "app.MealsData.get_catalog", return_value=catalog_mock
    )
    resp = test_client.get("/catalog")
    assert resp.status_code == 200
    assert resp.text == '["tomato", "potato", "pizza"]'
    meals_data_mock.assert_called_once()


def test_classify(test_client, mocker):
    example_predictions = ["example", "classification_predictions", "list"]
    logger_mock = mocker.patch("app.app.logger.info")
    model_mock = mocker.patch("app.classification_inference")
    mocker.patch(
        "app.create_classification_predictions", return_value=example_predictions
    )
    resp = test_client.post("/classify", json={"image": "example_image"})
    assert logger_mock.call_count == 4
    model_mock.assert_called_once_with(image="example_image")
    assert resp.text == '["example", "classification_predictions", "list"]'
    assert resp.status_code == 200


def test_detection(test_client, mocker):
    example_predictions = ["example", "detection_predictions", "list"]
    inference_result_mock = {"predictions": [{"class": "tomato"}, {"class": "tomato"}]}
    logger_mock = mocker.patch("app.app.logger.info")
    load_image_mock = mocker.patch("app.load_image_for_detection")
    detection_inference_mock = mocker.patch(
        "app.detection_inference", return_value=inference_result_mock
    )
    mocker.patch(
        "app.create_classification_predictions", return_value=example_predictions
    )
    draw_result_image_mock = mocker.patch(
        "app.draw_result_image", return_value=example_predictions
    )
    resp = test_client.post("/detection", json={"image": "example_image"})
    assert logger_mock.call_count == 6
    load_image_mock.assert_called_once_with(image="example_image")
    detection_inference_mock.assert_called_once()
    draw_result_image_mock.assert_called_once()
    assert resp.text == '["example", "detection_predictions", "list"]'
    assert resp.status_code == 200
