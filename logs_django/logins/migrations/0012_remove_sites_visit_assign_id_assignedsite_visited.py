# Generated by Django 4.1.3 on 2022-12-06 04:43

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('logins', '0011_remove_assignedsite_user_assignedsite_added_by'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='sites',
            name='visit_assign_id',
        ),
        migrations.AddField(
            model_name='assignedsite',
            name='visited',
            field=models.BooleanField(blank=True, null=True),
        ),
    ]