#!/usr/bin/env python3

from nicegui import ui, app
from nicegui.events import ValueChangeEventArguments

from typing import Literal

import os


def _static_lookup(prefix, *paths, default = 'default', format = '.png'):
    remap = {
        '1': 'B',
        '2': 'A',
        '3': 'S',
        'B': '1',
        'A': '2',
        'S': '3',
        'None': default,
    }
    remap = {f'{k}{format}': f'{v}{format}' for k, v in remap.items()}
    for path in paths:
        path = os.path.join('static', prefix, path) + format
        if os.path.exists(path):
            return path

        # try 123 -> ABS lookup
        path = os.path.join(os.path.dirname(path), remap.get(os.path.basename(path)))
        if os.path.exists(path):
            return path

        # fallback
        path = os.path.join('static', prefix, default) + format
        if os.path.exists(path) in remap:
            return path


## resources
# https://act.hoyolab.com/app/zzz-game-record/index.html?hyl_presentation_style=fullscreen#/zzz/roles/1261/detail?role_id=1501350231&server=prod_gf_eu
# https://zenless-zone-zero.fandom.com/wiki/Drive_Disc

def show(event: ValueChangeEventArguments):
    name = type(event.sender).__name__
    ui.notify(f'{name}: {event.value}')

ui.button('Button', on_click=lambda: ui.notify('Click'))
with ui.row():
    ui.checkbox('Checkbox', on_change=show)
    ui.switch('Switch', on_change=show)
ui.radio(['A', 'B', 'C'], value='A', on_change=show).props('inline')

with ui.row():
    ui.input('Text input', on_change=show)
    ui.select(['One', 'Two'], value='One', on_change=show)
ui.link('And many more...', '/documentation').classes('mt-8')

Slot = Literal[1, 2, 3, 4, 5, 6]



class DiskDriveCard(ui.card):

    set = None
    rank = None
    
    def _on_rank_changed(self, event: ValueChangeEventArguments):
        if event.value is None:
            self.level.set_visibility(False)
        else:
            self.level.set_visibility(True)
            old_max = self.level._props['max']
            self.level._props['min'] = 0
            self.level._props['max'] = 6 + event.value * 3
            if old_max and self.level.value == old_max:
                self.level.value = self.level._props['max']
            else:
                self.level.value = min(self.level.value, self.level._props['max'])
        self.level.update()

    def _set_level(self, change):
        self.level.value = max(self.level._props['min'], min(self.level._props['max'], self.level.value + change))

    def _change_disc_image(self, set, rank = None):
        return _static_lookup('icons/drive-disc', f'{set}/{rank}', f'{set}')

    def __init__(self, slot: Slot, rarities, sets):
        super().__init__()
        self.slot = slot
        with self:
            ui.label(f'Slot #{slot}')
            with ui.card_section():
                with ui.row().classes('w-full'):
                    with ui.column().classes('w-32'):
                        ui.label('w-32')
                        pass
                    with ui.column().classes('w-64'):
                        ui.label('w-64')
                        pass
                with ui.row().classes('w-32'):
                    image = ui.image()
            
            with ui.card_section().classes('w-96'):
                self.set = ui.select(sets,  label = 'Set', clearable = True)\
                    .classes('w-48')
                self.rank = ui.select(rarities, label = 'Rank', clearable = True)\
                    .classes('w-32')\
                    .bind_enabled_from(self.set, 'value')\
                    .on_value_change(self._on_rank_changed)
                self.level = ui.number(label = "Enhance", value = 0, min = 0, max = 21, precision = 0, prefix = "+", step = 1)\
                    .classes('w-16')\
                    .bind_enabled_from(self.rank, 'value')
            
                
            with ui.card_actions().classes('w-full justify-end'):
                ui.button('Reset')\
                    .on_click(lambda x: self._set_level(-15))\
                    .bind_enabled_from(self.level)
                ui.button('-3')\
                    .on_click(lambda x: self._set_level(-3))\
                    .bind_enabled_from(self.level)
                ui.button('+3')\
                    .on_click(lambda x: self._set_level(+3))\
                    .bind_enabled_from(self.level)
                ui.button('Max')\
                    .on_click(lambda x: self._set_level(+15))\
                    .bind_enabled_from(self.level)
            
            image.bind_source_from(self.set, 'value', lambda x: self._change_disc_image(x, self.rank.value))\
                 .bind_source_from(self.rank, 'value', lambda x: self._change_disc_image(self.set.value, x))
            

sets = {
    'branch-blade-song': 'Branch & Blade Song',
    'astral-voice': 'Astral Voice',
}
rarities = {
    1: 'B-rank',
    2: 'A-rank',
    3: 'S-rank',
}



with ui.row():
    for slot in Slot.__args__:
        DiskDriveCard(slot, rarities, sets).tight()

with ui.button(icon='thumb_up') as node:
    node.tooltip('I like this!').classes('bg-green')

ui.image('static/icons/shared/attribute/physical.png').classes('w-16')
ui.image('static/icons/shared/attribute/physical.png').classes('w-32')
ui.image('static/icons/shared/attribute/physical.png').classes('w-64')
ui.image('static/icons/shared/attribute/physical.png').classes('w-128')



app.add_static_files('/static', 'static')
ui.run(title = 'ZZZ Calculator')
