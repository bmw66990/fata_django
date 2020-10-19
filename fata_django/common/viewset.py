from rest_framework import viewsets, filters
from django_filters import rest_framework
from rest_framework_jwt import authentication
from common.permission_data import rbac_filter_queryset
from common.utils.page import LargeResultsSetPagination
from common.utils.response import JsonResponse
from rest_framework import status

class CustomViewBase(viewsets.ModelViewSet):
    # pagination_class = LimitOffsetPagination
    # filter_class = ServerFilter
    queryset = ''
    serializer_class = ''
    permission_classes = ()
    filter_fields = ()
    search_fields = ()
    ordering_fields = ()
    pagination_class = LargeResultsSetPagination
    filter_backends = (rest_framework.DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter,)
    authentication_classes = (authentication.JSONWebTokenAuthentication,)

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        data_per = self.insert_data_permission(request,serializer.Meta.model)
        if data_per != '':
            datas = request.data.copy()
            data = dict(datas,**data_per)
            serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        headers = self.get_success_headers(serializer.data)
        return JsonResponse(data=serializer.data, msg="创建成功", code=status.HTTP_200_OK, status=status.HTTP_200_OK,
                            headers=headers)

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset())
        try:
            queryset = rbac_filter_queryset(user=request.user, queryset=queryset)
        except:
            queryset  = queryset
        # 分页结果
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)
        # 序列化
        serializer = self.get_serializer(queryset, many=True)
        return JsonResponse(data=serializer.data, code=status.HTTP_200_OK, msg="列表获取成功", status=status.HTTP_200_OK)

    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance)
        return JsonResponse(data=serializer.data, code=status.HTTP_200_OK, msg="列表检索成功", status=status.HTTP_200_OK)

    def update(self, request, *args, **kwargs):
        partial = kwargs.pop('partial', False)
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data, partial=partial)
        serializer.is_valid(raise_exception=True)
        self.perform_update(serializer)
        if getattr(instance, '_prefetched_objects_cache', None):
            # If 'prefetch_related' has been applied to a queryset, we need to
            # forcibly invalidate the prefetch cache on the instance.
            instance._prefetched_objects_cache = {}

        return JsonResponse(data=serializer.data, msg="更新成功", code=status.HTTP_200_OK, status=status.HTTP_200_OK)

    def destroy(self, request, *args, **kwargs):
        # 进行逻辑删除  将status的状态改成false
        instance = self.get_object()
        serializeries = self.get_serializer(instance)
        data = serializeries.data
        data['status'] = False
        serializer = self.get_serializer(instance, data=data)
        serializer.is_valid(raise_exception=False)
        # self.perform_update(serializer)
        # 真正的删除，彻底的删除掉
        instance = self.get_object()
        self.perform_destroy(instance)
        return JsonResponse(data=[{'msg':'删除成功'}], code=status.HTTP_200_OK, msg="删除成功", status=status.HTTP_200_OK)

    #增加数据权限内容
    def insert_data_permission(self,request,models):
        try:
            return {'belong_dept':request.user.role.first().depts.id,'create_by':request.user.id,'update_by':request.user.id}
        except:
            return ''

