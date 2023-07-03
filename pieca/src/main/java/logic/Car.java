package logic;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Car {
   private int no;
   private String maker;
   private String name;
   private String car_size;
   private String car_type;
   private String release_year;
   private int min_price;
   private int max_price;
   private int min_range;
   private int max_range;
   private int avg_min_fuel;
   private int avg_max_fuel;
   private int dt_min_fuel;
   private int dt_max_fuel;
   private int high_min_fuel;
   private int high_max_fuel;
   private int min_output;
   private int max_output;
   private int min_output_motor;
   private int max_output_motor;
   private int min_torque;
   private int max_torque;
   private int min_torque_motor;
   private int max_torque_motor;
   private int min_capacity;
   private int max_capacity;
   private int overall_length;
   private int overall_height;
   private int overall_width;
   private int wheelbase;
   private String img;
   private String channel;
   
}