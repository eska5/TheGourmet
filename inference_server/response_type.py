class Meal:
    def __init__(self, name: str, description: str, certainty: float):
        self.name = name
        self.certainty = certainty
        self.description = description

    def to_dict(self) -> dict:
        return {"name": self.name, "description": self.description, "certainty": str(self.certainty)}
