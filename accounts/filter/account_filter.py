import django_filters as filters
from accounts.models import Consumer, Role, Deportment


class UserFilter(filters.FilterSet):

    name = filters.CharFilter(method='user_name',label='用户姓名', lookup_expr='icontains')
    mobile  = filters.CharFilter(method='user_phone',label='用户电话',lookup_expr='icontains')
    status = filters.BooleanFilter(method='user_state',label='用户状态',lookup_expr='icontains')
    category = filters.CharFilter(method='category_fun',label='账号类别',lookup_expr='icontains')

    def user_name(self,queryset,name,value):

        return queryset.filter(name=value)

    def user_phone(self,queryset,name,value):
        return queryset.filter(mobile = value)

    def user_state(self,queryset,name,value):
        return queryset.filter(status = value)

    def category_fun(self,queryset,name,value):
        return queryset.filter(category=value)

    class Meta:
        model = Consumer
        fields = "__all__"


class RoleFilter(filters.FilterSet):

    name  = filters.CharFilter(method='user_name',label='用户姓名',lookup_expr='icontains')
    status = filters.BooleanFilter(method='user_status',label='用户状态',lookup_expr='icontains')

    def user_name(self,queryset,name,value):
        return queryset.filter(name = value)

    def user_status(self,queryset,name,value):
        return queryset.filter(status = value)

    class Meta:
        model  = Role
        fields = "__all__"


class DepartmentFilters(filters.FilterSet):

    name = filters.CharFilter(method='name_fun',label='部门姓名',lookup_expr='icontains')

    def name_fun(self,queryset,name,value):
        return queryset.filter(name__icontaions=value)

    class Meta:
        model = Deportment
        fields = "__all__"

