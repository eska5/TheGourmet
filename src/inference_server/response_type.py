class Meal:
    def __init__(self, description: dict, certainty: float):
        self.name: str = description["name"]
        self.calories: int = description["calories"]
        self.allergens: list = description["allergens"]
        self.certainty: float = certainty

    def to_dict(self) -> dict:
        return {
            "name": self.name,
            "certainty": str(self.certainty),
            "calories": self.calories,
            "allergens": self.allergens,
        }
