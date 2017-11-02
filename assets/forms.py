# -*- encoding: utf-8 -*-

from django import forms


class TvMediaAdminForm(forms.ModelForm):
    def save(self, commit=True):
        obj = super(TvMediaAdminForm, self).save(commit=False)
        obj.type = 2
        if commit: obj.save()
        return obj


class RadioMediaAdminForm(forms.ModelForm):
    def save(self, commit=True):
        obj = super(RadioMediaAdminForm, self).save(commit=False)
        obj.type = 1
        if commit: obj.save()
        return obj

