package controller;

import java.io.IOException;

import utility.LoginUtility;
import Main.Main;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.Button;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

/**
 * Classe di controllo per l'interfaccia di login
 * @author Mattia Menna
 *
 */
public class LoginController {
	/**
	 * TextField dell'username
	 */
	@FXML
	private TextField username;
	/**
	 * TextField per la password
	 */
	@FXML
	private PasswordField password;
	/**
	 * Bottone per loggarsi
	 */
	@FXML
	private Button login;
	/**
	 * Bottone per registrarsi
	 */
	@FXML
	private Button registrati;
	/**
	 * Bottone per annullare
	 */
	@FXML
	private Button annulla;
	
	/**
	 * Funzione che gestisce le operazioni da effettuare alla pressione del tasto login
	 */
	@FXML
	public void login(){
		
		Main.clips.assertString("(login)");
		Main.clips.assertString("(autore si)");
		
		
		LoginUtility lu = new LoginUtility();
	
		if(!username.getText().equals("") && !password.getText().equals("")){
			if(lu.correctPassword(username.getText(), password.getText())){
				Main.clips.eval("(load-facts Utenti/"+username.getText() + ")");
				Stage stage = (Stage) annulla.getScene().getWindow();
				 stage.close();
				 
			}
			else{
				Alert alert = new Alert(AlertType.ERROR);
				alert.setTitle("Login non corretto!");
				alert.setHeaderText("Errore!");
				alert.setContentText("Nome utente o/e password non corretti, Riprovare");

				alert.showAndWait();
			}
		
			
		}
		else{
			Alert alert = new Alert(AlertType.ERROR);
			alert.setTitle("Campo vuoto!");
			alert.setHeaderText("Errore!");
			alert.setContentText("Prego, riempire tutti i campi e riprovare");

			alert.showAndWait();
		}
		
		
		
	}
	/**
	 * Funzione che gestisce le operazioni da effettuare alla pressione del tasto registrati
	 */
	@FXML
	public void registrati(){
		Parent root;
		try {
			root = FXMLLoader.load(getClass().getResource("registrazione.fxml"));
			Main.scene = new Scene(root,441,311);
			Stage stage = (Stage)registrati.getScene().getWindow();
			stage.setScene(Main.scene);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	/**
	 * Funzione che gestisce le operazioni da effettuare alla pressione del tasto annulla
	 */
	@FXML
	public void annulla(){
		 Stage stage = (Stage) annulla.getScene().getWindow();
		 stage.close();
	}
	

}
