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
		
		launch(args);
	}

public void start(Stage stage) throws IOException{
	
	Utility.classificazioneUtente();

	
	
	
	Parent root = FXMLLoader.load(getClass().getResource("GUI.fxml"));
	
	Scene sc = new Scene(root,600,400);
	
    stage.setTitle("GoodReads Expert System");
    stage.setScene(sc);
    stage.setResizable(false);
    stage.show();
	
	
	
}


}
