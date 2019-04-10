# Generated by Django 2.1.1 on 2018-10-12 09:17

import django.core.validators
from django.db import migrations, models
import django.db.models.deletion
import uuid


class Migration(migrations.Migration):

    dependencies = [
        ('assets', '0021_auto_20180903_1132'),
    ]

    operations = [
        migrations.CreateModel(
            name='CommandFilter',
            fields=[
                ('org_id', models.CharField(blank=True, db_index=True, default='', max_length=36, verbose_name='Organization')),
                ('id', models.UUIDField(default=uuid.uuid4, primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=64, verbose_name='Name')),
                ('is_active', models.BooleanField(default=True, verbose_name='Is active')),
                ('comment', models.TextField(blank=True, default='', verbose_name='Comment')),
                ('date_created', models.DateTimeField(auto_now_add=True)),
                ('date_updated', models.DateTimeField(auto_now=True)),
                ('created_by', models.CharField(blank=True, default='', max_length=128, verbose_name='Created by')),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='CommandFilterRule',
            fields=[
                ('org_id', models.CharField(blank=True, db_index=True, default='', max_length=36, verbose_name='Organization')),
                ('id', models.UUIDField(default=uuid.uuid4, primary_key=True, serialize=False)),
                ('type', models.CharField(choices=[('regex', 'Regex'), ('command', 'Command')], default='command', max_length=16, verbose_name='Type')),
                ('priority', models.IntegerField(default=50, help_text='1-100, the lower will be match first', validators=[django.core.validators.MinValueValidator(1), django.core.validators.MaxValueValidator(100)], verbose_name='Priority')),
                ('content', models.TextField(help_text='One line one command', max_length=1024, verbose_name='Content')),
                ('action', models.IntegerField(choices=[(0, 'Deny'), (1, 'Allow')], default=0, verbose_name='Action')),
                ('comment', models.CharField(blank=True, default='', max_length=64, verbose_name='Comment')),
                ('date_created', models.DateTimeField(auto_now_add=True)),
                ('date_updated', models.DateTimeField(auto_now=True)),
                ('created_by', models.CharField(blank=True, default='', max_length=128, verbose_name='Created by')),
                ('filter', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='rules', to='assets.CommandFilter', verbose_name='Filter')),
            ],
            options={
                'ordering': ('priority', 'action'),
            },
        ),
        migrations.AddField(
            model_name='systemuser',
            name='cmd_filters',
            field=models.ManyToManyField(blank=True, related_name='system_users', to='assets.CommandFilter', verbose_name='Command filter'),
        ),
    ]
