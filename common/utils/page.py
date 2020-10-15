from rest_framework.pagination import PageNumberPagination, LimitOffsetPagination
from collections import OrderedDict
from rest_framework.response import Response


class LargeResultsSetPagination(LimitOffsetPagination):
    page_size = 10
    page_query_param = 'page'
    page_size_query_param = 'size'
    max_page_size = 10000

    def get_paginated_response(self, data):
        # 当前页码
        current = int(self.offset / self.limit + 1)
        code = 200
        message = '数据获取成功'
        if not data:
            message = "data not found"

        return Response(OrderedDict([
            ('code', code),
            ('message', message),
            ('count', self.count),
            ('current', current),
            ('next', self.get_next_link()),
            ('previous', self.get_previous_link()),
            ('data', data),
        ]))