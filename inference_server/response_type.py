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
