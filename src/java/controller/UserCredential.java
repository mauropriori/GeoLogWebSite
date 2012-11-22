/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import javax.validation.constraints.Size;
import org.hibernate.validator.constraints.NotEmpty;

public class UserCredential {
    @NotEmpty
    @Size(min = 1, max = 50)
    private String userName;
    @NotEmpty
    @Size(min = 1, max = 20)
    private String password;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
