package hello.world;

import android.app.Activity;
import android.os.Bundle;
import android.view.Window;
import android.view.Gravity;
import android.view.MotionEvent;
import android.graphics.Typeface;
import android.widget.TextView;
import android.view.WindowManager;
import android.view.WindowInsets;
import android.view.WindowInsetsController;

public class main extends Activity {
	int fc=0xFF000000;
	int bc=0xFFFFFFFF;
	boolean a=false;
	TextView tv;
	
	@Override
	protected void onCreate(Bundle b){
		super.onCreate(b);
		getActionBar().hide();
		tv = new TextView(this);
		Typeface tf = Typeface.createFromAsset(getAssets(), "fonts/ndot.ttf");
		String txt = getString(getResources().getIdentifier("txt","string","hello.world"));
		tv.setTypeface(tf);
		tv.setGravity(Gravity.CENTER);
		tv.setText(txt);
		tv.setTextSize(24);
		tv.setTextColor(fc);
		tv.setBackgroundColor(bc);
		setContentView(tv);
	}
	@Override
	public void onAttachedToWindow(){
		super.onAttachedToWindow();
		Window w = getWindow();
		WindowManager.LayoutParams lp = w.getAttributes();
		lp.layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES;
		w.setAttributes(lp);
		w.setDecorFitsSystemWindows(false);
		WindowInsetsController wic = w.getInsetsController();
		wic.hide(WindowInsets.Type.systemBars());
		wic.setSystemBarsBehavior(WindowInsetsController.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE);
	}
	@Override
	public boolean dispatchTouchEvent(MotionEvent e){
		if(e.getAction() == MotionEvent.ACTION_DOWN || e.getAction() == MotionEvent.ACTION_UP){
			if (a){
				tv.setTextColor(fc);
				tv.setBackgroundColor(bc);
			}
			else {
				tv.setBackgroundColor(fc);
				tv.setTextColor(bc);
			}
			a=!a;
			return true;
		}
		return super.dispatchTouchEvent(e);
	}
}
