from django.contrib import admin
from .models import ContactMessage, Certificate

@admin.register(ContactMessage)
class ContactMessageAdmin(admin.ModelAdmin):
    list_display = ['name', 'email', 'subject', 'created_at']
    list_filter = ['created_at']
    search_fields = ['name', 'email', 'subject']



@admin.register(Certificate)
class CertificateAdmin(admin.ModelAdmin):
    list_display = ['title', 'organization', 'date_obtained']
    list_filter = ['organization', 'date_obtained']
    search_fields = ['title', 'organization']
    date_hierarchy = 'date_obtained'