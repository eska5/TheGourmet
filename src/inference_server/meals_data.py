import yaml


class MealsData:
    with open("descriptions.yaml", "r", encoding="utf8") as stream:
        descriptions = yaml.safe_load(stream)["descriptions"]

    @classmethod
    def get_descriptions(cls) -> dict:
        return cls.descriptions

    @classmethod
    def get_labels(cls) -> list:
        return MealsData.descriptions.keys()

    @classmethod
    def get_catalog(cls) -> list:
        catalog = []
        for meal in cls.descriptions.keys():
            catalog.append(cls.descriptions[meal]["name"])
        return catalog
