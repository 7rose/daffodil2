import 'package:event_bus/event_bus.dart';

//class DrawerEvent {
//  var eventName = 'open';
//  DrawerEvent(this.eventName);
//}

final eventBus = EventBus();
class LilacGlobal {
  EventBus getEventBus(){
    return eventBus;
  }
}