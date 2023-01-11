# Generated by Django 4.1.3 on 2022-12-05 10:06

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('logins', '0010_sites_visit_assign_id'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='assignedsite',
            name='user',
        ),
        migrations.AddField(
            model_name='assignedsite',
            name='added_by',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, related_name='visit_added_by', to=settings.AUTH_USER_MODEL),
            preserve_default=False,
        ),
    ]