/*
 * @file Hero.java
 * @brief This program stores all the heros information and calulates/performs some functions needed for the battle.
 * @author Athena Hartigan
 * @data February 21st, 2023
 */

import java.util.Random;

public class Hero {
    private String heroName; //declares private string variable
    private int hitPoints; //declares private int variable
    private int lightAttackDamage;
    private int heavyAttackDamage;

    public Hero(){ //default constructor, initializing the variables
        heroName = "Null";
        hitPoints = 0;
        lightAttackDamage = 0;
        heavyAttackDamage = 0;
    }
    public Hero(String heroName, int hitPoints, int lightAttackDamage, int heavyAttackDamage){ //overloaded constructor, initializing the variables
        this.heroName = heroName; //sets private heroName equal to what the heroName
        this.hitPoints = hitPoints;
        this.lightAttackDamage = lightAttackDamage;
        this.heavyAttackDamage = heavyAttackDamage;
    }

    public void setHeroName(String heroName) {
        this.heroName = heroName;
    } //methods to set variables
    public void setHitPoints(int hitPoints) {
        this.hitPoints = hitPoints;
    }
    public void setLightAttackDamage(int lightAttackDamage) {
        this.lightAttackDamage = lightAttackDamage;
    }
    public void setHeavyAttackDamage(int heavyAttackDamage) {
        this.heavyAttackDamage = heavyAttackDamage;
    }

    public String getHeroName() { //get methods to get variables
        return heroName;
    }
    public int getHitPoints() {
        return hitPoints;
    }
    public int getLightAttackDamage() {
        return lightAttackDamage;
    }
    public int getHeavyAttackDamage() {
        return heavyAttackDamage;
    }

    public boolean isAlive (){ // if the heros hitpoints are above zero then the hero is alive
        return hitPoints > 0;
    }

    public void takeDamage(){ //calculates how many hitpoints the hero lost
        hitPoints = hitPoints - attack();

    }

    public int attack(){ //attacks with a heavy attack 25% of the time and light attack 75% of the time
        Random rand = new Random();
        if (rand.nextInt(100) < 25){
            return heavyAttackDamage;
        }
        else{
            return lightAttackDamage;
        }

    }

    public void displayHealth(){
        if (!isAlive()){ //prints if the hero is not alive
            System.out.println(heroName + " has fainted");
        }
        else { //prints if hero is alive
            System.out.println(heroName + " has " + hitPoints + " HP left");
        }
    }

}
