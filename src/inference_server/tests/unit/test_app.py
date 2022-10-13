# pylint: disable=W0621
from unittest.mock import MagicMock

import pytest
from app import app


@pytest.fixture
def test_client():
    app.config["TESTING"] = True
    with app.app_context():
        with app.test_client() as flask_client:
            yield flask_client


def test_catalog(test_client, mocker):
    catalog_mock = ["tomato", "potato", "pizza"]

    meals_data_mock = mocker.patch("app.MealsData.get_catalog", return_value=catalog_mock)
    resp = test_client.get("/catalog")
    assert resp.status_code == 200
    assert resp.text == '["tomato", "potato", "pizza"]'
    meals_data_mock.assert_called_once()


@pytest.mark.parametrize("test_input,expected", [(None, "not loaded"), (MagicMock(), "loaded")])
def test_ping(test_client, mocker, test_input, expected):
    mocker.patch("app.MODEL", test_input)
    resp = test_client.get("/ping")
    assert resp.status_code == 200
    assert resp.text == f"App is running. Model is {expected}."
