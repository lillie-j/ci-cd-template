"""
Provides simple unit tests for demonstrating a CI/CD pipeline template.
"""

import pytest
from pydantic import ValidationError
from backend.api import CTResponse, app
from fastapi.testclient import TestClient

# Create Test client to validate calls to endpoints without spinning up a server
client = TestClient(app)


"""Test Fields/Attributes"""


def test_count_is_computed_correctly():
    # Ensure count is correctly calculated from message
    ct = CTResponse(
        message=[
            "Data & AI Strategy",
            "Data & AI Enablement",
            "Data & AI Innovation",
            "Data & AI Factory",
        ]
    )
    assert ct.count == 4


def test_count_is_immutable():
    # Ensure count is calculated from message, even if explicitly passed
    ct = CTResponse(message=["One", "Two"], count=999)
    assert ct.count == 2


def test_inactive_since_is_set():
    # Ensure inactive_since is set if explicitly passed
    ct = CTResponse(
        message=[
            "Data & AI Strategy",
            "Data & AI Enablement",
            "Data & AI Innovation",
            "Data & AI Factory",
        ],
        inactive_since=2024,
    )
    assert ct.inactive_since == 2024


def test_inactive_since_not_set():
    # Ensure inactive_since is None if not explicitly passed
    ct = CTResponse(
        message=[
            "Data & AI Strategy",
            "Data & AI Enablement",
            "Data & AI Innovation",
            "Data & AI Factory",
        ],
    )
    assert ct.inactive_since is None


"""Test Model Validation"""


def test_inactive_since_is_non_int():
    # Ensure Validation Error is raised if inactive_since is set as non int
    with pytest.raises(ValidationError) as exc_info:
        ct = CTResponse(
            message=[
                "Data & AI Strategy",
                "Data & AI Enablement",
                "Data & AI Innovation",
                "Data & AI Factory",
            ],
            inactive_since="Invalid",
        )
    assert "Input should be a valid integer" in str(exc_info.value)


def test_message_contains_non_strings():
    # Ensure Validation Error is raised if message is a list containing non strings
    with pytest.raises(ValidationError) as exc_info:
        CTResponse(message=[1, 2, 3])
    assert "Input should be a valid string" in str(exc_info.value)


def test_message_contains_empty_string():
    # Ensure Validation Error is raised if message is a list containing empty string
    with pytest.raises(ValidationError) as exc_info:
        CTResponse(message=["Valid", ""])
    assert "Message item at index 1 cannot be empty or whitespace" in str(
        exc_info.value
    )


def test_message_contains_whitespace():
    # Ensure Validation Error is raised if message is a list containing whitespace
    with pytest.raises(ValidationError) as exc_info:
        CTResponse(message=[" ", " "])
    assert "Message item at index 0 cannot be empty or whitespace" in str(
        exc_info.value
    )


def test_message_handles_leading_whitespace():
    # Ensure Validation Error is not raised if message is a list containing valid strings which lead with whitespace
    ct = CTResponse(message=[" Valid", " Another Valid"])
    assert ct.message == [" Valid", " Another Valid"]


"""Test API Endpoints"""


def test_old_ct_names_endpoint():
    # Test endpoint returns expected results
    response = client.get("/old_ct_names")
    assert response.status_code == 200

    data = response.json()
    assert isinstance(data["message"], list)
    assert data["count"] == len(data["message"])
    assert data["inactive_since"] == 2025


def test_new_ct_names_endpoint():
    response = client.get("/new_ct_names")
    assert response.status_code == 200

    data = response.json()
    assert isinstance(data["message"], list)
    assert data["count"] == len(data["message"])
    assert data["inactive_since"] is None
