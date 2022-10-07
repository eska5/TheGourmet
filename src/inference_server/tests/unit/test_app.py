from unittest.mock import patch, mock_open

import pytest

from app import app

@pytest.fixture
def test_client(mocker):
    app.config["TESTING_XD"] = True
    with app.app_context():
        with app.test_client() as flask_client:
            yield flask_client


def test_catalog(test_client, mocker):
    mocker.patch("tensorflow.keras.models.load_model")
    resp = test_client.get("/ping")
    assert resp.text == "App is running. Model status is Loaded."
    assert resp.status_code == 200


def test_catalog_fail(test_client, mocker):

    model_mock = mocker.patch("tensorflow.keras.models.load_model")
    model_mock.return_value = None
    resp = test_client.get("/ping")
    assert resp.text == "App is running. Model status is Not loaded."
    assert resp.status_code == 200
