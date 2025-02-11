from nicegui.elements.mixins.disableable_element import DisableableElement

class DisableableContainer(DisableableElement):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._child_states = {}
        self._sync_enabled()

    def _handle_enabled_change(self, enabled: bool) -> None:
        self._sync_enabled()
        super()._handle_enabled_change(enabled)

    def _sync_enabled(self):
        def _update(element):
            element_id = id(element)
            if element != self and hasattr(element, 'set_enabled'):
                if self.enabled:
                    if element_id in self._child_states:
                        element.set_enabled(self._child_states[element_id])
                    else:
                        element.set_enabled(True)
                else:
                    if element_id not in self._child_states:
                        self._child_states[element_id] = element.enabled
                    element.set_enabled(False)
            for key, slot in element.slots.items():
                for child in slot.children:
                    _update(child)
        _update(self)
