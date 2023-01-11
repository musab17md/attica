# Generated by Django 4.1.3 on 2022-12-06 12:04

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('logins', '0015_alter_assignedsite_visited'),
    ]

    operations = [
        migrations.AlterField(
            model_name='assignedsite',
            name='added_by',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
    ]