from unittest.mock import MagicMock

from meals_operator.meal_operator import get_suggestions


def test_list_meals(mocker):
    example_list = ["tomato, apple, banana"]
    # with patch("builtins.open", mock_open(read_data='test')):
    #     with open("data/meals.txt") as f:
    #         print(f.readlines())
    readlines_mock = MagicMock(return_value=example_list)
    file_open_mock = MagicMock(readlines=readlines_mock)
    mocker.patch("builtins.open", readlines=example_list)
    get_suggestions()
    # file_open_mock.assert_called_once()
