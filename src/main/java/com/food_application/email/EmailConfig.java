package com.food_application.email;

import java.io.InputStream;
import java.util.Properties;

public class EmailConfig {

    private static final Properties properties = new Properties();

    static {

        try {

            InputStream input =
                    EmailConfig.class.getClassLoader()
                            .getResourceAsStream("email.properties");

            if(input != null){

                properties.load(input);

            }

        }

        catch(Exception e){

            e.printStackTrace();

        }

    }

    public static String getUsername(){

        return properties.getProperty("mail.username");

    }

    public static String getPassword(){

        return properties.getProperty("mail.password");

    }

}