import os
from django.urls import path
from rest_framework_jwt.views import (
    obtain_jwt_token,
    refresh_jwt_token,
    verify_jwt_token,
)

# from .views import (
#     BaseEndPoint,
#     PKEndPoint,
#     ProfileView,
#     ResetPasswordView,
#     ChangePasswordView,
#     ProfileView,
# )
# import pprint

app_name = os.getcwd().split(os.sep)[-1]

urlpatterns = [
    path('token-auth/', obtain_jwt_token, name='login'),
    path('token-refresh/', refresh_jwt_token, name='token-refresh'),
    path('token-verify/', verify_jwt_token, name='token-verify'),
]