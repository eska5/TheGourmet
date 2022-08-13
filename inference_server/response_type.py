import json

import requests


class ClassifiedMeal:
    def __init__(self, name: str, description: str, certainty: float):
        self.name = name
        self.certainty = certainty
        if description is None:
            self.description = "Brak danych"
        else:
            self.description = description

    def to_dict(self) -> dict:
        return {"name": self.name, "description": self.description, "certainty": str(self.certainty)}


# TO DO remove this function and copy it to Dockerfile from meal_operator
def get_meal(meal_name: str) -> dict:
    url = "https://data.mongodb-api.com/app/data-bduvb/endpoint/data/v1/action/findOne"
    payload = json.dumps({
        "collection": "meals",
        "database": "gourmet",
        "dataSource": "Cluster0",
        "filter": {"name": meal_name},
        "projection": {
            "_id": 0,
            "name": 1,
            "calories": 1,
            "allergens": 1,
            "photos": 1,

        }
    })
    headers = {
        'Content-Type': 'application/json',
        'Access-Control-Request-Headers': '*',
        'api-key': '4wyTSiqX9oBUrS8o3X9WnSAwifMFmXfa1DdO39ElkY3WuxjAkOQcUExbDtSXzWJ7',
    }
    response = requests.request("POST", url, headers=headers, data=payload)
    return json.loads(response.text)["document"]
