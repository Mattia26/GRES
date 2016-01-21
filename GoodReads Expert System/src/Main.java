import net.sf.clipsrules.jni.*;


import java.io.IOException;


import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;


public class Main extends Application {
	
	public static Environment clips = new Environment();

	
	public static void main(String args[]){
		clips.load("GRES.clp");
		clips.assertString("(interfaccia)");
		
		launch(args);
	}

public void start(Stage stage) throws IOException{
	
	DefaultChoises.classificazioneUtente();

	
	
	
	Parent root = FXMLLoader.load(getClass().getResource("GUI.fxml"));
	
	Scene sc = new Scene(root,600,400);
	sc.getStylesheets().add(
			getClass().getResource("Style.css").toExternalForm());
    stage.setTitle("GRES");
    stage.setScene(sc);
    stage.setResizable(false);
    stage.show();
	
	
	
}


}
