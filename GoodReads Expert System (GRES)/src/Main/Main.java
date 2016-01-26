package Main;



import java.io.IOException;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;
import net.sf.clipsrules.jni.Environment;
/**
 * Classe di partenza dell'applicazione
 * @author Mattia Menna
 *
 */
public class Main extends Application{
	/**
	 * Scena principale
	 */
	public static Scene scene;
	/**
	 * Ambiente clips principale
	 */
	public static Environment clips = new Environment();;
	
	/**
	 * Funzione main per l'avvio dell'applicazione
	 * @param args
	 */
	public static void main(String[] args){
		
		clips.load("GRES.clp");
		
		launch(args);
		
		clips.run();
		
	
	}
	/**
	 * Funzione di start per l'interfaccia fx
	 */
	public void start(Stage stage) throws IOException{
		
	

		
		
		Parent root = FXMLLoader.load(getClass().getResource("Login.fxml"));
		
		scene = new Scene(root);
		
		
	    stage.setTitle("GoodReads Expert System");
	    stage.setScene(scene);
	    stage.setResizable(false);
	    stage.show();
		
		
		
	}

	
}
