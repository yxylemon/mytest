package com.jxlg.util;

import java.util.Random;

public class RandomNum {
	
	//生成6位随机数
	public static String getRandomNumber(){
		Random random = new Random();
		String result="";
		for(int i=0;i<6;i++){
		result+=random.nextInt(10);
		}
		return result;
	}
	//生成18位随机数
	public static String getLongNumber(){
		Random random = new Random();
		String result="";
		for(int i=0;i<18;i++){
			result+=random.nextInt(10);
		}
		return result;
	}
	//生成4位随机数
		public static String getFloatNumber(){
			Random random = new Random();
			String result="";
			for(int i=0;i<4;i++){
			result+=random.nextInt(10);
			}
			return result;
		}
}
