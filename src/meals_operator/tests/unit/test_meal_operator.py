from unittest.mock import MagicMock

from meal_operator import get_suggestions, add_labels, save_image


def test_get_suggestions(mocker):
    example_list = ["tomato", "banana", "apple"]
    example_suggestions = {'suggestions': example_list}
    open_mock = mocker.patch("builtins.open")
    yaml_safe_load_mock = mocker.patch("meal_operator.yaml.safe_load", return_value=example_suggestions)
    assert get_suggestions() == sorted(example_list)
    open_mock.assert_called_once()
    yaml_safe_load_mock.assert_called_once()


def test_add_labels(mocker):
    example_path = "/example/labels"
    example_label = "tomato"
    open_mock = mocker.patch("builtins.open")
    add_labels(value=example_label, path=example_path)
    open_mock.assert_called_once()


def test_save_image_newdir(mocker):
    example_path = "/example/images"
    example_title = "potato"
    example_image = "base64_example_image"
    image_mock = MagicMock()
    isdir_mock = mocker.patch("meal_operator.os.path.isdir", return_value=False)
    mkdir_mock = mocker.patch("meal_operator.os.mkdir")
    open_mock = mocker.patch("builtins.open")
    add_labels_mock = mocker.patch("meal_operator.add_labels")
    image_open_mock = mocker.patch("meal_operator.Image.open", return_value=image_mock)
    base_decode_mock = mocker.patch("meal_operator.base64.b64decode")
    bytes_io_mock = mocker.patch("meal_operator.BytesIO")
    save_image(path=example_path, coded_image=example_image, title=example_title)
    isdir_mock.assert_called_once_with(f"{example_path}/{example_title}")
    mkdir_mock.assert_called_once_with(f"{example_path}/{example_title}")
    add_labels_mock.assert_called_once_with(value=example_title, path=f"{example_path}/labels.yaml")
    image_open_mock.assert_called_once()
    base_decode_mock.assert_called_once()
    bytes_io_mock.assrrt_called_once()
    assert open_mock.call_count == 3


def test_save_image_dir_exists(mocker):
    example_path = "/example/images"
    example_title = "potato"
    example_image = "base64_example_image"
    image_mock = MagicMock()
    isdir_mock = mocker.patch("meal_operator.os.path.isdir", return_value=True)
    open_mock = mocker.patch("builtins.open")
    image_open_mock = mocker.patch("meal_operator.Image.open", return_value=image_mock)
    base_decode_mock = mocker.patch("meal_operator.base64.b64decode")
    bytes_io_mock = mocker.patch("meal_operator.BytesIO")
    save_image(path=example_path, coded_image=example_image, title=example_title)
    isdir_mock.assert_called_once_with(f"{example_path}/{example_title}")
    image_open_mock.assert_called_once()
    base_decode_mock.assert_called_once()
    bytes_io_mock.assrrt_called_once()
    assert open_mock.call_count == 2
