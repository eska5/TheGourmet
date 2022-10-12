from unittest.mock import MagicMock, patch

import pytest
from app import app


@pytest.fixture
def test_client(mocker):
    app.config["TESTING"] = True
    mocker.patch("builtins.open")
    mocker.patch("app.tensorflow.keras.models.load_model")
    mocker.patch("app.app.logger.info")
    with app.app_context():
        with app.test_client() as flask_client:
            yield flask_client


def test_catalog(test_client, mocker):
    descriptions_mock = {
        "descriptions": {
            "potato": {"name": "Potato"},
            "tomato": {"name": "Tomato"},
            "pizza": {"name": "Pizza"},
        }
    }
    mocker.patch("app.yaml.safe_load", return_value=descriptions_mock)
    json_dump_mock = mocker.patch("app.json.dumps")
    resp = test_client.get("/catalog")
    assert resp.status_code == 200
    assert json_dump_mock.call_count == 2


def test_classify(test_client, mocker):
    image_mock = MagicMock()
    image_open_mock = mocker.patch("app.Image.open", return_value=image_mock)
    base_decode_mock = mocker.patch("app.base64.b64decode")
    bytes_io_mock = mocker.patch("app.BytesIO")
    cvt_color_mock = mocker.patch("app.cv2.cvtColor")
    np_array_mock = mocker.patch("app.np.array")
    np_expand_dims = mocker.patch("app.np.expand_dims")
    cv2_resize_mock = mocker.patch("app.cv2.resize")
    model_mock = mocker.patch("app.MODEL", return_value=MagicMock())
    model_mock.predict.return_value = MagicMock()
    resp = test_client.post("/classify", json={"image": "example_photo"})
    assert True


# def test_app_health_check_model_not_loaded(test_client):
#     resp = test_client.get("/ping")
#     assert resp.status_code == 200
#     assert str(resp.data)[2:-1] == "App is running. Model status is Not loaded."
#     assert resp.content_type == "application/json"
#
#
# @patch('app.tensorflow.keras.models.load_model', MagicMock())
# def test_app_health_check_model_loaded(test_client):
#     resp = test_client.get("/ping")
#     assert resp.status_code == 200
#     assert str(resp.data)[2:-1] == "App is running. Model status is Loaded."
#     assert resp.content_type == "application/json"
