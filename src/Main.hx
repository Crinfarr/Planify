package ;

import views.MainView;
import haxe.ui.HaxeUIApp;

class Main {
    static function main() {
        final app = new HaxeUIApp();
        app.ready(() -> {
            app.title = "Planify";
            app.addComponent(new MainView());
            app.start();
        });
    }
}