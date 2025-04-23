package ch83;

public class Medic extends Unit implements ICure {
	public Medic(){
        this.name="메딕";
    }
    public void cure(Unit unit){
    	if(unit instanceof ICure) { // Tank 타입은 false
    		unit.hp++;
    		System.out.println(unit.name+"을 치료하다");
    	}
    }
    /*
    public void cure(ICure unit){
    	if(unit instanceof ICure) {
    		unit.hp++; // 강제 형 변환이 필요
    		System.out.println(unit.name+"을 치료하다");
    	}
    }
    */
}
