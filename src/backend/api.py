"""
Provides simple API endpoints for demonstrating a CI/CD pipeline template.
"""

from typing import List, Optional
from fastapi import FastAPI
from pydantic import BaseModel, field_validator, model_validator

app = FastAPI()


class CTResponse(BaseModel):
    """
    Represents a response containing CTs (capability teams) in Capgemini Invent EDA

    Attributes:
        message (List[str]): A list of CT names
        count: Count of CTs in message - computed automatically without input
        inactive_since: Year since CT names became inactive
    """

    message: List[str]
    count: int = 0
    inactive_since: Optional[int] = None

    # Validates that message (list) is non empty - class method
    @field_validator("message")
    def non_empty_message(cls, val):
        """
        Validates that there are no empty items in message
        """
        for i, item in enumerate(val):
            if not item.strip():
                raise ValueError(
                    f"Message item at index {i} cannot be empty or whitespace"
                )
        return val

    # Compute count of CTs for response - class method
    @model_validator(mode="before")
    def compute_count(cls, values):
        """
        Returns the number of items in message
        """
        messages = values.get("message", [])
        values["count"] = len(messages)
        return values


@app.get("/old_ct_names", response_model=CTResponse)
def old_ct_names() -> CTResponse:
    """
    Returns CT names (old format)
    """
    message = [
        "Data & AI Strategy",
        "Data & AI Innovation",
        "Data & AI Factory",
        "Data & AI Enablement",
    ]
    return CTResponse(message=message, inactive_since=2025)


@app.get("/new_ct_names", response_model=CTResponse)
def new_ct_names() -> CTResponse:
    """
    Returns CT names (new format)
    """
    message = [
        "Data & AI Strategy",
        "Data & AI Innovation",
        "Data & AI Factory",
        "Operational Analytics",
    ]
    return CTResponse(message=message)
