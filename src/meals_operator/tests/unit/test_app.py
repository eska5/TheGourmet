import os
import tempfile

import pytest

from flaskr import create_app
from app import app


@pytest.fixture
def client():
    app.config['TESTING'] = True

    with app.app_context():
        with app.test_client() as client:
            yield client


def test_app_health_check(client):
    resp = client.get('/ping')
    assert resp.status_code == 200
    assert str(resp.data)[2:-1] == "App is running."
    assert resp.content_type == "application/json"





