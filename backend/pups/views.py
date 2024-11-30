from rest_framework import viewsets
from rest_framework.permissions import IsAdminUser
from .models import ContentItem
from .serializers import ContentItemSerializer

class ContentItemViewSet(viewsets.ModelViewSet):
    queryset = ContentItem.objects.all()
    serializer_class = ContentItemSerializer
    permission_classes = [IsAdminUser]  # Solo permite usuarios admin
    