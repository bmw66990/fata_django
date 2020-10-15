from django.contrib.auth.handlers.modwsgi import check_password
from django.contrib.auth.hashers import make_password
from rest_framework import status
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from accounts.filter.account_filter import UserFilter, RoleFilter, DepartmentFilters
from accounts.models import Consumer, Role, Deportment, RoleMenu, RoleButton
from accounts.serializers import AccountsSerializers, RoleSerializers, GroupSerializer, \
    RoleMenuSerializers, RoleButtonSerializers
from common.utils.response import JsonResponse
from common.viewset import CustomViewBase
from django_filters import rest_framework as filters

class AccountViewset(CustomViewBase):
    queryset = Consumer.objects.all().filter(is_delete=False).order_by('-id')
    serializer_class = AccountsSerializers
    filter_class = UserFilter
    filter_backends = (filters.DjangoFilterBackend,)
    filterset_fields = "__all__"

    def create(self, request, *args, **kwargs):
        user_save = request.data.copy()
        password = make_password('123456',None,'pbkdf2_sha256')
        user_save.update({'password':password})
        serializer = self.get_serializer(data=user_save)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        headers = self.get_success_headers(serializer.data)
        return JsonResponse(data=serializer.data, msg="创建成功", code=status.HTTP_200_OK, status=status.HTTP_200_OK,
                            headers=headers)

    def destroy(self, request, *args, **kwargs):
        # 进行逻辑删除  将status的状态改成false
        instance = self.get_object()
        serializeries = self.get_serializer(instance)
        data = serializeries.data
        data['is_delete'] = True
        serializer = self.get_serializer(instance, data=data)
        serializer.is_valid(raise_exception=False)
        self.perform_update(serializer)
        return JsonResponse(data=[{'msg': '删除成功'}], code=status.HTTP_200_OK, msg="删除成功", status=status.HTTP_200_OK)


    @action(methods=['put'], detail=False, permission_classes=[IsAuthenticated],url_path='change_password')
    def password(self, request, pk=None):
        """
        修改密码
        """
        user = request.user
        old_password = request.data['old_password']
        if check_password(old_password, user.password):
            new_password1 = request.data['new_password1']
            new_password2 = request.data['new_password2']
            if new_password1 == new_password2:
                user.set_password()
                user.save()
                return Response('密码修改成功!', status=status.HTTP_200_OK)
            else:
                return Response('新密码两次输入不一致!', status=status.HTTP_400_BAD_REQUEST)
        else:
            return Response('旧密码错误!', status=status.HTTP_400_BAD_REQUEST)



class RoleViewset(CustomViewBase):
    queryset = Role.objects.all()
    serializer_class = RoleSerializers
    filter_class = RoleFilter
    filter_backends = (filters.DjangoFilterBackend,)
    filterset_fields = "__all__"


class DepartmentViewset(CustomViewBase):
    queryset = Deportment.objects.all().order_by('-id')
    serializer_class = GroupSerializer
    filter_class =  DepartmentFilters
    filter_backends = (filters.DjangoFilterBackend,)
    filterset_fields = "__all__"


class RoleMenuViewsets(CustomViewBase):
    queryset = RoleMenu.objects.all()
    serializer_class = RoleMenuSerializers
    filter_backends = (filters.DjangoFilterBackend,)
    filterset_fields = "__all__"

class RoleButtonViewsets(CustomViewBase):
    queryset = RoleButton.objects.all().order_by('-id')
    serializer_class = RoleButtonSerializers
    filter_backends = (filters.DjangoFilterBackend,)
    filterset_fields = "__all__"