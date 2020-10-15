from rest_framework.views import exception_handler
from rest_framework import status


# 公共异常数据组装返回
def common_handler(exc, context):
    # Call REST framework's default exception handler first,
    # to get the standard error response.
    response = exception_handler(exc, context)

    # Now add the HTTP status code to the response.
    if response is not None:
        print(response.data)
        response.data.clear()
        response.data['code'] = response.status_code
        response.data['data'] = []

        if response.status_code == 404:
            try:
                response.data['message'] = response.data.pop('detail')
                response.data['message'] = "Not found"
            except KeyError:
                response.data['message'] = "Not found"

        if response.status_code == 400:
            response.data['message'] = 'Input error'

        elif response.status_code == 401:
            response.data['message'] = "Auth failed"

        elif response.status_code >= 500:
            response.data['message'] =  "Internal service errors"

        elif response.status_code == 403:
            response.data['message'] = "Access denied"

        elif response.status_code == 405:
            response.data['message'] = 'Request method error'
    return response

# jwt 数据整理返回
def jwt_response_payload_handler(token, user=None, request=None):
    """为返回的结果添加用户相关信息"""
    # 用户角色登录菜单权限信息
    try:
        role_permission_menu = user.role.first().role_permission_list if user.role else ""
    except:
        role_permission_menu = ""
    # # 用户角色登录按钮权限信息
    try:
        role_permission_button = [
            {'name': button.name, 'code': button.code, 'describe': button.describe, 'status': button.status} for
            button in user.role.first().role_button.all()] if user.role.first() else ""
    except:
        role_permission_button = ''

    return {
            "code": status.HTTP_200_OK,
            "data": {
                "token": token,
                'user_id': user.id,
                'name': user.name,
                'role_permission_menu':role_permission_menu,
                'role_permission_button':role_permission_button,
                'status': 'ok',
                'type': 'account',
                'currentAuthority': 'admin',
            },
            "message": ""
        }