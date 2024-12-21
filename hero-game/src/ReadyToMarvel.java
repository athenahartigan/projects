/*
 * @file ReadyToMarvel.java
 * @brief This program has two heros fight each other to see who will win. There is two different displays with one showing a lot of details on how the fight went and another just showing the results. The info is taken from a file and HEro.java is used for the specific info of each hero. The doBattle method actaully performs the battle.
 * @author Athena Hartigan
 * @data February 21st, 2023
 */

import java.util.ArrayList;
import java.util.Scanner;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.util.InputMismatchException;

public class ReadyToMarvel {

    public static void doBattle (Hero hero1, Hero hero2, boolean flag) {
        String line = "═════════════════════════════════════════════════════════"; //decoration line
        System.out.println(hero1.getHeroName() + " VS. " + hero2.getHeroName());  //prints heroes fighting
        int hero1HeavyAttack = hero1.getHeavyAttackDamage(); //stores what hero1's heavy attack damage is in hero1HeavyAttack
        int hero1LightAttack = hero1.getLightAttackDamage();
        int hero2HeavyAttack = hero2.getHeavyAttackDamage();
        int hero2LightAttack = hero2.getLightAttackDamage();
        hero1.setHeavyAttackDamage(hero2HeavyAttack); //sets hero1's heavyAttackDamage to hero2's heavyAttackDamage so when a hero takes damage based on how the other hero attacked
        hero1.setLightAttackDamage(hero2LightAttack);
        hero2.setHeavyAttackDamage(hero1HeavyAttack);
        hero2.setLightAttackDamage(hero1LightAttack);
        if(flag){ //does this if printFlag = true
            while(hero1.isAlive() && hero2.isAlive()) { //does this while both heroes are alive
                int hero1BeforeHitPoints = hero1.getHitPoints(); //stores the hitpoints before attack
                int hero2BeforeHitPoints = hero2.getHitPoints();
                System.out.println(line); //prints decoration line
                hero1.displayHealth(); //displays the hero's health
                hero2.displayHealth();
                System.out.println(line);
                hero1.takeDamage(); //runs the function takeDamage() on hero1 from Hero.java
                hero2.takeDamage();
                if (hero2.getHitPoints() == (hero2BeforeHitPoints - hero1HeavyAttack)){ //prints if hero1 does a heavy attack
                    System.out.println(hero1.getHeroName() + " performs a heavy attack with Damage: " + hero1HeavyAttack);
                }
                else { //prints if hero1 does a light attack
                    System.out.println(hero1.getHeroName() + " performs a light attack with Damage: " + hero1LightAttack);
                }
                if (hero1.getHitPoints() == (hero1BeforeHitPoints - hero2HeavyAttack)){
                    System.out.println(hero2.getHeroName() + " performs a heavy attack with Damage: " + hero2HeavyAttack);
                }
                else {
                    System.out.println(hero2.getHeroName() + " performs a light attack with Damage: " + hero2LightAttack);
                }
            }
            System.out.println(line);
            if(!hero1.isAlive() && !hero2.isAlive()){ //does this if both heroes are not alive
                hero1.displayHealth();
                hero2.displayHealth();
                System.out.println(line);
                System.out.println(hero1.getHeroName() + " and " + hero2.getHeroName() + " are evenly matched"); //prints saying that the heroes are evenly matched
            }
            else if(!hero1.isAlive()){ //prints if only hero1 is not alive
                    hero1.displayHealth();
                    hero2.displayHealth();
                    System.out.println(line);
                    System.out.println(hero2.getHeroName() + " VANQUISHES " + hero1.getHeroName() + " with "+ hero2.getHitPoints() + " HP to spare"); //prints to basically say one hero beat the other with x amount of hitpoints to spare
            }
            else{
                hero1.displayHealth();
                hero2.displayHealth();
                System.out.println(line);
                System.out.println(hero1.getHeroName() + " VANQUISHES " + hero2.getHeroName() + " with "+ hero1.getHitPoints() + " HP to spare");
            }
        }
        else { //does this if printflag is false
            while (hero1.isAlive() && hero2.isAlive()) {
                hero1.takeDamage();
                hero2.takeDamage();
            }
            if (!hero1.isAlive() && !hero2.isAlive()){
                System.out.println(hero1.getHeroName() + " and " + hero2.getHeroName() + " are evenly matched");
            }
            else if (!hero1.isAlive()){
                System.out.println(hero2.getHeroName() + " VANQUISHES " + hero1.getHeroName() + " with " + hero2.getHitPoints() + " HP to spare");
            }
            else{
                System.out.println(hero1.getHeroName() + " VANQUISHES " + hero2.getHeroName() + " with "+ hero1.getHitPoints() + " HP to spare");
            }
        }
        System.out.println(); //prints a line to separate different matches for appearance
    }

    public static void main(String[] args) throws IOException{
        Scanner scnr = new Scanner(System.in); //allows for user input
        boolean run = true; //declares a boolean called run
        while(run) { //does this while run is true
            try {
                String flag = args[0]; //sets flag equal to what is first entered
                boolean printFlag;
                if (flag.equals("true") || flag.equals("false")){ //goes into the if statement if the user wrote true or false
                    printFlag = Boolean.parseBoolean(args[0]); //turns the string into a boolean
                }
                else{
                    throw new Exception ("the print flag is incorrectly set"); //exception thrown if the user didn't write true/false
                }
                System.out.println("Enter file name:"); //prompts user to enter the file name
                String fileName = scnr.next(); //sets filename to what use wrote
                FileInputStream inputStream = new FileInputStream(fileName); //opens file
                Scanner inscnr = new Scanner(inputStream); //creates a new scanner to read the opened file
                ArrayList<Hero> team1Heroes = new ArrayList<>(); //creates an arraylist of object heros
                ArrayList<Hero> team2Heroes = new ArrayList<>();
                run = false; //sets run to false to not go through the loop again (only goes through again if exception thrown)
                inscnr.nextLine(); //reads the first line in the file
                while (inscnr.hasNext()) { //continues while there is something in the file to read
                    String[] heroInfo = inscnr.nextLine().split(","); //breaks up the lines in the file and stores the strings that are separated by commas
                    Hero hero = new Hero(heroInfo[0], Integer.parseInt(heroInfo[1]), Integer.parseInt(heroInfo[2]), Integer.parseInt(heroInfo[3])); //creates a hero object and initializes the hero's name, hitPoints, lightAttack, heavyAttack (parse changes them to the right type of variable needed)

                    int team = Integer.parseInt(heroInfo[4]); //changes the 5th item in the array (the team numer) from a string to an int

                    if (team == 1) { //does this if the hero is on team 1
                        team1Heroes.add(hero); //adds the hero to the ream1Heroes array
                    } else if (team == 2) {
                        team2Heroes.add(hero);
                    } else { //throws exception if an invalid team is given
                        throw new Exception("Invalid team");
                    }
                }
                inputStream.close();
                for (int i = 0; i < team1Heroes.size(); i++){ //runs through the hereos
                    doBattle(team1Heroes.get(i), team2Heroes.get(i), printFlag);  //calls doBattle with the hero objects in the arrays and the printFlag
                }
            } catch (FileNotFoundException exct) { //catches exception if the file the user entered couldn't be found
                System.out.println("Could not open input file. Enter another file name:"); //prints this message if the file cannot be found
            } catch (InputMismatchException ime) { //catches this exception if an InputMismatchException is thrown
                System.out.println("Invalid answer"); //prints this if InputMismatchException is thrown
            } catch (Exception other) { //catches any other exceptions
                System.out.println(other.getMessage());  //prints the message
            }
        }
    }
}
