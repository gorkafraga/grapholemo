## Implicit_learning task, May 2019
##
## GFG modified from Christina Lutz, based on a script by Sarah Di Pietro
##########################################################################################################################

scenario_type=fMRI; #In order to test an fMRI mode scenario without an external connection scenario_type=fMRI_emulation; otherwise scenario_type=fMRI
pulses_per_scan = 1;		#registers the first of the specified number of pulses #how many square wave pulses are produced by the MRI scanner during one scan??
scan_period=1000;			#time between complete MRI scans in ms
pulse_code=199;			#used to identify main pulses in fMRI mode in the Analysis window and the logfile
pulse_width=1;				#pulses are 1 ms long #width of pulses in ms
#default_output_port=1; 	#Assigned to the port parameter for stimulus events that do not define that parameter; does not affect output port used for responses
write_codes=false; 		#Writes codes to output port that depend on the event; value will be written to output port at the occurance of all stimuli for which port_code is defined
response_matching=simple_matching;	#Affects how response active stimuli are associated with responses
response_port_output=true;

#active_buttons = 4;
#button_codes = 1,2,3,4;
active_buttons = 2;						#indicates how many response buttons are used in the scenario. Must match buttons selected on response panel
button_codes = 20,21;			#Assigns numerical codes to each response button used in the scenario --> logfile and output port (if write_codes=true)
target_button_codes = 25,26;	#Only used for correct responses to active targets

$stimx=0;
$stimy=0;
$stimPresDur=700;
$cross_size = 30;
$Schulfont="Arial";



default_font_size = 50; 
default_font = "Arial";
default_text_color = 0,0,0; #black
default_background_color = 128,128,128; #grey

#$FFlearned="AllRead_MRFont1";
#$FFfamiliar="AllRead_MRFont2";
#$FFnew="AllRead_MRFont3"; #same for familiar and new 
begin;

#TRIAL AND STIMULI ARRAY DEFINITION -------------------------------------------------------------------------------------------------------------------
picture { text { caption=" 		
Herzlich Willkommen! 

Sie werden nun auf dem Screen eine Reihe an Symbolen und Buchstaben sehen. 

Drücken Sie einen beliebigen Knopf sobald ein Symbol bzw. Buchstabe die Farbe ändert.
  
Bereit? (Drücken Sie einen Knopf, um fortzufahren)"; font_size=14; font_color=0,0,0;}intro_txt; x=-10; y=0;} intro_pic;
picture{	text intro_txt; x=0; y=100;
			bitmap {filename="LEMO_logo_black.png";preload=true;width=213;height=213;alpha=-1;};x=0; y=-100;
	} intropic;
	

# Start picture
picture { text { caption="  ... noch ein paar Sekunden bis die Maschinen starten. Gleich gehts los!"; font_size=14; font_color=0,0,0;}start_txt; x=-10; y=0;} start_txt_pic;
picture{	text start_txt; x=0; y=100;
			bitmap {filename="LEMO_logo_black.png";preload=true;width=213;height=213;alpha=-1;};x=0; y=-100;
	} start_task;
	
	 trial {trial_type=first_response;
			trial_duration = forever;
			terminator_button = 1;
			stimulus_event {
				picture start_task;
				code="start";
			} start_task_event;
	} start;
#Fixation cross (part of jittered ISI, see later). 
text{caption="+";font_color = 0,0,0; font_size=$cross_size;preload=true;}cross;
text{caption="+";font_color = 0,128,0; font_size=$cross_size;preload=true;}crosswaiting;
text{caption="+";font_color = 0,128,0; font_size=$cross_size;preload=true;}crosswaiting_end;

trial{
	stimulus_event
		{picture{
			text cross; x=$stimx;y=$stimy;
			}fixation_cross;
		}eventFixation;
}fixation_trial;

#Rest trials. Longer pause, counterbalanced(see later). 
text{caption="+";font_color = 0,0,0;preload=true;}rest_text;
trial{
	stimulus_event
		{picture{
			text rest_text;
			x=$stimx;y=$stimy;
			}picRest; code="10";
	}eventRest;
}rest_trial;  

##LETTERS
array{text{caption="b";preload=true;}letter1; 
		text{caption="m";preload=true;}letter2;
		text{caption="u";preload=true;}letter3;
		text{caption="g";preload=true;}letter4;
		text{caption="t";preload=true;}letter5;
		text{caption="z";preload=true;}letter6;
		text{caption="e";preload=true;}letter7;
		text{caption="p";preload=true;}letter8;
		text{caption="a";preload=true;}letter9;
		text{caption="r";preload=true;}letter10;
	}letter;

###FFtrained (symbols from B1 and B2 of learning Task) 
array{text{caption="N";preload=true;}FFtrainedB12_1; 
		text{caption="R";preload=true;}FFtrainedB12_2;
		text{caption="V";preload=true;}FFtrainedB12_3;
		text{caption="3";preload=true;}FFtrainedB12_4;
		text{caption="4";preload=true;}FFtrainedB12_5;
		text{caption="A";preload=true;}FFtrainedB12_6;
		text{caption="E";preload=true;}FFtrainedB12_7;
		text{caption="I";preload=true;}FFtrainedB12_8;
	   text{caption="0";preload=true;}FFtrainedB12_9;
	   text{caption=":";preload=true;}FFtrainedB12_10;
	}FFtrained;
	
##FFtrained BACKUP (in case one of the regular first two blocks had to be interrupted and a backup block -B3 or B4 -  was run)
array{text{caption="N";preload=true;}FFtrainedB13_1; 
		text{caption="R";preload=true;}FFtrainedB13_2;
		text{caption="V";preload=true;}FFtrainedB13_3;
		text{caption="3";preload=true;}FFtrainedB13_4;
		text{caption="4";preload=true;}FFtrainedB13_5;
		text{caption="i";preload=true;}FFtrainedB13_6;
		text{caption="a";preload=true;}FFtrainedB13_7;
		text{caption="e";preload=true;}FFtrainedB13_8;
		text{caption="6";preload=true;}FFtrainedB13_9;
		text{caption="²";preload=true;}FFtrainedB13_10;

	}FFtrainedBlocks13;

array{text{caption="N";preload=true;}FFtrainedB14_1; 
		text{caption="R";preload=true;}FFtrainedB14_2;
		text{caption="V";preload=true;}FFtrainedB14_3;
		text{caption="3";preload=true;}FFtrainedB14_4;
		text{caption="4";preload=true;}FFtrainedB14_5;
		text{caption="n";preload=true;}FFtrainedB14_6;
		text{caption="r";preload=true;}FFtrainedB14_7;
		text{caption="v";preload=true;}FFtrainedB14_8;
		text{caption="9";preload=true;}FFtrainedB14_9;
		text{caption=";";preload=true;}FFtrainedB14_10;

	}FFtrainedBlocks14;
	
array{text{caption="A";preload=true;}FFtrainedB23_1; 
		text{caption="E";preload=true;}FFtrainedB23_2;
		text{caption="I";preload=true;}FFtrainedB23_3;
		text{caption="0";preload=true;}FFtrainedB23_4;
		text{caption=":";preload=true;}FFtrainedB23_5;
		text{caption="i";preload=true;}FFtrainedB23_6;
		text{caption="a";preload=true;}FFtrainedB23_7;
		text{caption="e";preload=true;}FFtrainedB23_8;
		text{caption="6";preload=true;}FFtrainedB23_9;
		text{caption="²";preload=true;}FFtrainedB23_10;

	}FFtrainedBlocks23;

array{text{caption="A";preload=true;}FFtrainedB24_1; 
		text{caption="E";preload=true;}FFtrainedB24_2;
		text{caption="I";preload=true;}FFtrainedB24_3;
		text{caption="0";preload=true;}FFtrainedB24_4;
		text{caption=":";preload=true;}FFtrainedB24_5;
		text{caption="n";preload=true;}FFtrainedB24_6;
		text{caption="r";preload=true;}FFtrainedB24_7;
		text{caption="v";preload=true;}FFtrainedB24_8;
		text{caption="9";preload=true;}FFtrainedB24_9;
		text{caption=";";preload=true;}FFtrainedB24_10;

	}FFtrainedBlocks24;
	 
	
##FFfamiliar
array{text{caption="a";preload=true;}FFfamiliar1; 
		text{caption="b";preload=true;}FFfamiliar2;
		text{caption="c";preload=true;}FFfamiliar3;
		text{caption="d";preload=true;}FFfamiliar4;
		text{caption="e";preload=true;}FFfamiliar5;
		text{caption="f";preload=true;}FFfamiliar6;
		text{caption="g";preload=true;}FFfamiliar7;
		text{caption="h";preload=true;}FFfamiliar8;
		text{caption="i";preload=true;}FFfamiliar9;
		text{caption="j";preload=true;}FFfamiliar10;

	}FFfamiliar;

##FFnew
array{text{caption="Y";preload=true;}FFnew1; 
		text{caption="y";preload=true;}FFnew2;
		text{caption="Z";preload=true;}FFnew3;
		text{caption="w";preload=true;}FFnew4;
		text{caption="N";preload=true;}FFnew5;
		text{caption="b";preload=true;}FFnew6;
		text{caption="P";preload=true;}FFnew7;
		text{caption="L";preload=true;}FFnew8;
		text{caption="K";preload=true;}FFnew9;
		text{caption="k";preload=true;}FFnew10;
	}FFnew;
 
#start, end, target pictures
#picture {bitmap {filename = "LEMO_logo_black.png"; preload = true; alpha=-1;width=360;height=341;}intro_pic; x = 0; y = 0;} intropic;	
picture {bitmap {filename = "responsebox.png"; preload = true; alpha=-1;width=260;height=241;}response_box; x = 0; y = 0;} responsebox;
picture {bitmap {filename = "LEMO_logo_black.png"; preload = true; alpha=-1;width=180;height=180;}target_pic; x = 0; y = 0;} targetpic;	
picture {bitmap {filename = "Aliensfarbig.png"; preload = true; alpha=-1;width=300;height=350;}end_pic; x = 0; y = 0;} endpic;	
text{caption="a";font_color = 0,0,255;preload=true;}example;

#Instruction-trials
trial { 
	trial_type = first_response; 
	trial_duration = forever; 
	stimulus_event{
			  picture intropic;
	} intropic_event;
}intropicTrial; 

trial { 
	trial_type = first_response; 
	trial_duration = 15000;
	stimulus_event{
			  picture endpic;
	} endpic_event;
} endTrial; 

trial { 
	trial_type = first_response; 
	trial_duration = forever; 
	stimulus_event{
			  picture responsebox;
	} response_event;
}responseTrial; 

trial { 
	trial_type = first_response; 
	trial_duration = forever; 
	stimulus_event{
			  picture targetpic;
	} target_event;
}targetTrial; 
		
#Definition of the stimulus-trial (750 ms presentation, in the middle of the screen)
trial{
	stimulus_event
		{picture
				{text letter1;
					x=$stimx;y=$stimy;
				}picStimulus;
		duration=$stimPresDur;
		}eventStimulus;
	}stimulus_trial;

trial{
	stimulus_event
		{picture
				{text letter1;
					x=$stimx;y=$stimy;
				}picStimulusColor;
		duration=$stimPresDur;
		}targEventStimulus;
	}targetstimulus_trial;
	
trial{stimulus_event{
	picture targetpic;
		duration=$stimPresDur;}targEventStimulus2;
	}targetstimulus_trial2;


#Definition of waiting-for-MR-pulse-trial
trial{
	stimulus_event
		{picture
			{text crosswaiting;x=$stimx;y=$stimy;}; 
	mri_pulse=1; duration=5000;code="100";}event_wait;	
}wait;

trial{
	stimulus_event
		{picture
			{text crosswaiting_end;x=$stimx;y=$stimy;}; 
	duration=26000;code="200";}event_wait_end;	
}wait_end;
#----------------------------------------------------------------------------------------------------------------
#start of PCL
#----------------------------------------------------------------------------------------------------------------
begin_pcl;

string Schulfont="Arial";
####################################################
#preset string cbFonts;(type[3] is for "new" condition)
array <string> font_type[3] = {"lemo6","AllRead-Armenian-matched_bold1","ERead_falsefont_AllRead_bold3"};
#array <string> font_type2[3] = {"AllRead_MRFont2","AllRead_MRFont3","AllRead_MRFont1"};
#array <string> font_type3[3] = {"AllRead_MRFont3","AllRead_MRFont1","AllRead_MRFont2"};

#if (int(cbFonts) == 1) then font_type = font_type;
#	elseif (int(cbFonts) == 2) then font_type = font_type2;
#	elseif (int(cbFonts) == 3) then font_type = font_type3;
#end;
####################################################
preset string learning_blocks_idx = "12";

if (int(learning_blocks_idx)==12) then FFtrained=FFtrained; 
	elseif (int(learning_blocks_idx)==13) then FFtrained=FFtrainedBlocks13; 
	elseif (int(learning_blocks_idx)==23) then FFtrained=FFtrainedBlocks23;
	elseif (int(learning_blocks_idx)==14) then FFtrained=FFtrainedBlocks14;
	elseif (int(learning_blocks_idx)==24) then FFtrained=FFtrainedBlocks24; 
 end;

####################################################
 array<string> condition_order[4]={"T","F","N","L"};
#array <string> condition_order[3]={"T","N","L"};
#-----------Prepare log file ------------------------------------------------------------------------------
string logfilename = logfile.filename(); #use filename as logfile name
logfile.set_filename(logfilename.replace(".log",+"_B"+learning_blocks_idx+".log")); #replace .log with other input + .log
logfilename = logfile.filename();		

if (file_exists(logfilename)) then 
	int i = 2;
		loop until !file_exists(logfilename.replace(".log", "-" + string(i) + ".log"))
	begin
        i = i + 1;
   end;
   logfilename = logfilename.replace(".log",  "-" + string(i) + ".log")
end;
logfile.set_filename(logfilename);
#output file
string scenarioName = "SymCtrlPost";
#output_port parallel1 = output_port_manager.get_port( 1 );
output_file outputfile = new output_file;

# Define headers of output file
if (logfile.subject().count()>0) then outputfile.open(logfilename.replace(".log",".txt")); # include response matching info here
else outputfile.open("NoSubj_"+scenarioName+"_B"+learning_blocks_idx+".txt");
end;

outputfile.print("trial\tblock\tstimIndex\tCondition\tVstimCaption\tISIjitter\tstimOnset\n");
#outputfile.print(condition_order+"\n"); # write in output file

#PORT CODES ------------------------------------------------------------------------------
array<int>targButton[2]={1,2}; 

string event_code_letter="60";
string event_code_FFtrained="70";
string event_code_FFfamiliar="80";
string event_code_FFnew="90";
string event_code_rest="50";
string event_code_fixation="40";
int port_code_letter=60;
int port_code_FFtrained=70;
int port_code_FFfamiliar=80;
int port_code_FFnew=90;
int port_code_rest=50;
int port_code_fixation=40;

string event_code_letter_targ="65";
string event_code_FFtrained_targ="75";
string event_code_FFfamiliar_targ="85";
string event_code_FFnew_targ="95";
int port_code_letter_targ=65;
int port_code_FFtrained_targ=75;
int port_code_FFfamiliar_targ=85;
int port_code_FFnew_targ=95;

int port_code_start=100;
int port_code_end=200;

#define blocks
array<text> blocks_letter_array[0][0];
blocks_letter_array.add(letter);
blocks_letter_array.add(letter);
blocks_letter_array.add(letter);
blocks_letter_array.add(letter);
blocks_letter_array.add(letter);
blocks_letter_array.add(letter);
blocks_letter_array.add(letter);
blocks_letter_array.add(letter);
blocks_letter_array.add(letter);
blocks_letter_array.add(letter);

array<text> blocks_FFtrained_array[0][0];
blocks_FFtrained_array.add(FFtrained);
blocks_FFtrained_array.add(FFtrained);
blocks_FFtrained_array.add(FFtrained);
blocks_FFtrained_array.add(FFtrained);
blocks_FFtrained_array.add(FFtrained);
blocks_FFtrained_array.add(FFtrained);
blocks_FFtrained_array.add(FFtrained);
blocks_FFtrained_array.add(FFtrained);
blocks_FFtrained_array.add(FFtrained);
blocks_FFtrained_array.add(FFtrained);

array<text> blocks_FFfamiliar_array[0][0];
blocks_FFfamiliar_array.add(FFfamiliar);
blocks_FFfamiliar_array.add(FFfamiliar);
blocks_FFfamiliar_array.add(FFfamiliar);
blocks_FFfamiliar_array.add(FFfamiliar);
blocks_FFfamiliar_array.add(FFfamiliar);
blocks_FFfamiliar_array.add(FFfamiliar);
blocks_FFfamiliar_array.add(FFfamiliar);
blocks_FFfamiliar_array.add(FFfamiliar);
blocks_FFfamiliar_array.add(FFfamiliar);
blocks_FFfamiliar_array.add(FFfamiliar);

array<text> blocks_FFnew_array[0][0];
blocks_FFnew_array.add(FFnew);
blocks_FFnew_array.add(FFnew);
blocks_FFnew_array.add(FFnew);
blocks_FFnew_array.add(FFnew);
blocks_FFnew_array.add(FFnew);
blocks_FFnew_array.add(FFnew);
blocks_FFnew_array.add(FFnew);
blocks_FFnew_array.add(FFnew);
blocks_FFnew_array.add(FFnew);
blocks_FFnew_array.add(FFnew);

#target is indicated by a 9 (stimuli arrays only contain 8 items)
array<int> letterOrder[10]={1,2,3,4,5,6,7,8,9,10}; 
array<int> FFtrainedOrder[10]={1,2,3,4,5,6,7,8,9,10};
array<int> FFfamiliarOrder[10]={1,2,3,4,5,6,7,8,9,10};
array<int> FFnewOrder[10]={1,2,3,4,5,6,7,8,9,10};

#Time of rest in between conditions is counterbalanced 3, 5, 7, 9 s - different order, but same time overall for each block
array<int> Rest1[4]={3000,5000,7000,9000};
array<int> Rest2[4]={9000,7000,5000,3000};
array<int> Rest3[4]={7000,3000,9000,5000};
array<int> Rest4[4]={5000,9000,3000,7000};
array<int> Rest5[4]={9000,3000,5000,7000};
array<int> Rest6[4]={7000,5000,9000,3000};
array<int> Rest7[4]={5000,7000,3000,9000};
array<int> Rest8[4]={3000,9000,7000,5000};

array <int> randISIRest[0][0]; 
randISIRest.add(Rest1);
randISIRest.add(Rest2);
randISIRest.add(Rest3);
randISIRest.add(Rest4);
randISIRest.add(Rest5);
randISIRest.add(Rest6);
randISIRest.add(Rest7);
randISIRest.add(Rest8);

array<int>isi_jitter[10]={331, 199, 249, 366, 178, 213, 214, 286, 269, 435}; #mean 274, between 100-500

int targOccurrence=random(0,2); #initialize variable, will be replaced afterwards

array<int>targOccArray[0][0];
targOccArray.add({0,1,1,2});
targOccArray.add({1,1,2,0});
targOccArray.add({1,2,0,1});
targOccArray.add({2,0,1,1});
targOccArray.add({1,2,0,1});
targOccArray.add({2,0,1,1});
targOccArray.add({0,1,1,2});
targOccArray.add({1,1,2,0});

array <int> targetPosition2[0][0];
targetPosition2.add({0,0,0,1,0,1,0,0,0,0});
targetPosition2.add({0,0,1,0,0,0,0,0,1,0});
targetPosition2.add({0,0,0,1,0,0,1,0,0,0});
targetPosition2.add({0,0,0,1,0,0,1,0,0,0});
targetPosition2.add({0,0,0,0,1,0,1,0,0,0});
targetPosition2.add({0,0,1,0,0,0,0,0,1,0});
targetPosition2.add({0,0,0,0,0,0,1,0,1,0});
targetPosition2.add({0,0,1,0,1,0,0,0,0,0});

 
#--------------------------------------------------------------
# Begin presentation 
#--------------------------------------------------------------
intropicTrial.present();
start.present();
#targetTrial.present(); #example

#waiting for the MR pulse
event_wait.set_port_code(port_code_start);
wait.present();
int t0=pulse_manager.main_pulse_time(1);
int trial_no=0; 

# main trial presentation
#--------------------------------------------------------------
condition_order.shuffle();
#term.print("condOrder"); term.print(condition_order);	

#LOOP through blocks (8 blocks of 8+2 stimuli/target per condition)
loop int k=1 until k>8 begin	
	
#randomize order of items within blocks
letterOrder.shuffle();
FFtrainedOrder.shuffle(); 
FFfamiliarOrder.shuffle(); 
FFnewOrder.shuffle(); 
array <int> targetPosition[10] = {0,0,0,0,0,0,0,0,0,0}; #initialize

   #Loop through conditions (letter/FFtrained/FFfamiliar/FFnew)
	loop int j=1 until j>4 begin 
	targOccurrence=targOccArray[k][j]; #target shall occur either 0, 1, or 2 times per block.
	term.print(condition_order[j]);term.print("-");	term.print(targOccurrence);	 term.print("\n");	
 		
		if (condition_order[j]=="L") then
			isi_jitter.shuffle();	
			#---------------------------
			if (targOccurrence==1) then
				targetPosition  = {0,0,0,0,0,0,0,0,0,1};
				targetPosition.shuffle(3,10);
			elseif (targOccurrence == 2) then 
				targetPosition  = targetPosition2[k]
 			else
				targetPosition  = {0,0,0,0,0,0,0,0,0,0};
			end;
			term.print(targetPosition); term.print("\n");			
			#--------------------------
			loop int i=1 until i>10 begin;
				#if letterOrder[i] == 9 && targOccurrence==1 && r<1 then 
				if (targetPosition[i] == 1) then 
					#term.print("if"); term.print("targ  "); term.print(targOccurrence);term.print("letterOrder[i]");term.print(letterOrder[i]); term.print("  "); term.print("r");term.print(r); term.print("  "); term.print("i");term.print(i);term.print("\n");
					targEventStimulus.set_response_active(true);
					targEventStimulus.set_event_code(event_code_letter_targ);
					targEventStimulus.set_target_button(targButton);
					targEventStimulus.set_port_code(port_code_letter_targ);
					#print stuff to output txt file
					trial_no=trial_no+1;	
					outputfile.print(trial_no);outputfile.print("\t"); #  Trial index from the beginning of the experiment is :((b-1)*40)+i
					outputfile.print(k);outputfile.print("\t"); 
					outputfile.print(i);outputfile.print("\t");
					#outputfile.print(blocks_letter_array[k][i].filename());outputfile.print("\t");
    				outputfile.print("letter");outputfile.print("\t");		 #print condition name
					outputfile.print("LetterTarget");outputfile.print("\t") ;
               #outputfile.print("letterTarget");outputfile.print("\t") ; #print stimulus name/caption
					outputfile.print(isi_jitter[i]);outputfile.print("\t");
					
					int stimOnset=clock.time()-t0;

					blocks_letter_array[k][letterOrder[i]].set_font_size(70);
					blocks_letter_array[k][letterOrder[i]].set_font_color(0,0,255);
					blocks_letter_array[k][letterOrder[i]].redraw();
					picStimulusColor.set_part(1, blocks_letter_array[k][letterOrder[i]]);

					targetstimulus_trial.present();
					outputfile.print(stimOnset);outputfile.print("\t");outputfile.print("\n");

										
				#r = r+1;
				elseif (targetPosition[i]==0) then 
  					picStimulus.set_part(1, blocks_letter_array[k][letterOrder[i]]);
					blocks_letter_array[k][letterOrder[i]].set_font_size(70);
					blocks_letter_array[k][letterOrder[i]].set_font_color(0,0,0);
				   blocks_letter_array[k][letterOrder[i]].redraw();


					eventStimulus.set_event_code(event_code_letter);
					eventStimulus.set_target_button(0);
					eventStimulus.set_port_code(port_code_letter);
				
					#print stuff to output txt file
					trial_no=trial_no+1;	
					outputfile.print(trial_no);outputfile.print("\t"); #  Trial index from the beginning of the experiment is :((b-1)*40)+i
					outputfile.print(k);outputfile.print("\t"); 
					outputfile.print(i);outputfile.print("\t");
 					outputfile.print("letter");outputfile.print("\t");		 
					outputfile.print(blocks_letter_array[k][letterOrder[i]].caption());outputfile.print("\t") ;
					outputfile.print(isi_jitter[i]);outputfile.print("\t");
					
					#eventStimulus.set_response_active(true);
					int stimOnset=clock.time()-t0;
					stimulus_trial.present();
					outputfile.print(stimOnset);outputfile.print("\t");outputfile.print("\n");
				end;
				
				eventFixation.set_event_code(event_code_fixation);
				eventFixation.set_port_code(port_code_fixation);
				eventFixation.set_duration(isi_jitter[i]);
				eventFixation.set_response_active(true);
				fixation_trial.present();
				
				i=i+1
			end;
			

		#this is the rest (counterbalanced 3, 5, 7, 9 s - different order, but same time overall for each block)		
		#term.print("randISIRest"); term.print(randISIRest[k][j]);
		picRest.set_part(1, cross); 
		eventRest.set_event_code(event_code_rest);
		rest_trial.set_duration(randISIRest[k][j]); 
		eventRest.set_event_code(event_code_rest);
		rest_trial.present();
		
		
		#r=0;
		elseif (condition_order[j]=="T") then
		isi_jitter.shuffle();
			#----------------------
			if (targOccurrence==1) then
				targetPosition = {0,0,0,0,0,0,0,0,0,1};
				targetPosition.shuffle(3,10);
			elseif (targOccurrence == 2) then 
				targetPosition  = targetPosition2[k]
			else
				targetPosition = {0,0,0,0,0,0,0,0,0,0};
			end;
			term.print(targetPosition); term.print("\n");			
			#--------------------------;
			#Same loop for trained-condition
			loop int i=1 until i>10 begin;
				#if FFtrainedOrder[i] == 9 && targOccurrence==1 && r<1 then 
				if (targetPosition[i] == 1) then 
					#term.print("if"); term.print("targ  "); term.print(targOccurrence);term.print("trainedOrder[i]");term.print(letterOrder[i]); term.print("  "); term.print("r");term.print(r); term.print("  "); term.print("i");term.print(i);term.print("\n");
					targEventStimulus.set_event_code(event_code_FFtrained_targ);
					targEventStimulus.set_target_button(targButton);
					targEventStimulus.set_port_code(port_code_FFtrained_targ);
					targEventStimulus.set_response_active(true);
					
					#print stuff to output txt file
					trial_no=trial_no+1;	
					outputfile.print(trial_no);outputfile.print("\t"); #  Trial index from the beginning of the experiment is :((b-1)*40)+i
					outputfile.print(k);outputfile.print("\t"); 
					outputfile.print(i);outputfile.print("\t");
					#outputfile.print(blocks_FFtrained_array[k][i].filename());outputfile.print("\t");
					outputfile.print("FFtrained");outputfile.print("\t");		 
					outputfile.print("FFtrainedTarget");outputfile.print("\t") ;
					outputfile.print(isi_jitter[i]);outputfile.print("\t"); 

					
					
					blocks_FFtrained_array[k][FFtrainedOrder[i]].set_font(font_type[1]); ##set font type according to counterbalancing
					blocks_FFtrained_array[k][FFtrainedOrder[i]].set_font_size(70);
					blocks_FFtrained_array[k][FFtrainedOrder[i]].set_font_color(0,0,255);
					blocks_FFtrained_array[k][FFtrainedOrder[i]].redraw();
					picStimulusColor.set_part(1, blocks_FFtrained_array[k][FFtrainedOrder[i]]); 
				
					int stimOnset=clock.time()-t0;
					targetstimulus_trial.present();
					outputfile.print(stimOnset);outputfile.print("\t");outputfile.print("\n");

				
 				elseif (targetPosition[i]==0) then 
					#term.print("else "); term.print("targ  "); term.print(targOccurrence);term.print("FFtrainedOrder[i] ");term.print(FFtrainedOrder[i]); term.print("  "); term.print("r");term.print(r); term.print("  "); term.print("i");term.print(i);term.print("\n");
					blocks_FFtrained_array[k][FFtrainedOrder[i]].set_font(font_type[1]); ##set font type according to counterbalancing
					blocks_FFtrained_array[k][FFtrainedOrder[i]].set_font_size(70);
				    blocks_FFtrained_array[k][FFtrainedOrder[i]].set_font_color(0,0,0);					
					blocks_FFtrained_array[k][FFtrainedOrder[i]].redraw();
					picStimulus.set_part(1, blocks_FFtrained_array[k][FFtrainedOrder[i]]); 
					eventStimulus.set_event_code(event_code_FFtrained);
					eventStimulus.set_target_button(0);
					eventStimulus.set_port_code(port_code_FFtrained);

					#print stuff to output txt file
					trial_no=trial_no+1;	
					outputfile.print(trial_no);outputfile.print("\t"); #  Trial index from the beginning of the experiment is :((b-1)*40)+i
					outputfile.print(k);outputfile.print("\t"); 
					outputfile.print(i);outputfile.print("\t");
					#outputfile.print(blocks_FFtrained_array[k][i].filename());outputfile.print("\t");
					outputfile.print("FFtrained");outputfile.print("\t");		 
					outputfile.print(blocks_FFtrained_array[k][FFtrainedOrder[i]].caption());outputfile.print("\t") ;
					outputfile.print(isi_jitter[i]);outputfile.print("\t"); 
 
					#eventStimulus.set_response_active(true);
					int stimOnset=clock.time()-t0;
					stimulus_trial.present();
					outputfile.print(stimOnset);outputfile.print("\t");outputfile.print("\n");
				end;
				
				eventFixation.set_event_code(event_code_fixation);
				eventFixation.set_port_code(port_code_fixation);
				eventFixation.set_duration(isi_jitter[i]);
				eventFixation.set_response_active(true);
				fixation_trial.present();
				
				i=i+1
			end;

		#this is the rest (counterbalanced 3, 5, 7, 9 s - different order, but same time overall for each block)	
		#term.print("randISIRest"); term.print(randISIRest[k][j]);
		picRest.set_part(1, cross); 
		eventRest.set_event_code(event_code_rest);
		rest_trial.set_duration(randISIRest[k][j]); 
		eventRest.set_event_code(event_code_rest);
		rest_trial.present();
		
		#r=0;
		
		elseif (condition_order[j]=="F") then
		isi_jitter.shuffle();
		#----------------------
			if (targOccurrence==1) then
				targetPosition = {0,0,0,0,0,0,0,0,0,1};
				targetPosition.shuffle(3,10);
			elseif (targOccurrence == 2) then 
				targetPosition  = targetPosition2[k]
			else
				targetPosition = {0,0,0,0,0,0,0,0,0,0};
			end;
		 term.print(targetPosition); term.print("\n");

		#--------------------------;
			#Same loop for familiar-condition
			loop int i=1 until i>10 begin;
				#if FFfamiliarOrder[i] == 9 && targOccurrence==1 && r<1 then 
				if (targetPosition[i] == 1) then
					#term.print("if "); term.print("targ  "); term.print(targOccurrence);term.print("FFfamiliarOrder[i] ");term.print(FFfamiliarOrder[i]); term.print("  "); term.print("r");term.print(r); term.print("  "); term.print("i");term.print(i);term.print("\n");
					targEventStimulus.set_response_active(true);
					targEventStimulus.set_event_code(event_code_FFfamiliar_targ);
					targEventStimulus.set_target_button(targButton);
					targEventStimulus.set_port_code(port_code_FFfamiliar_targ);
					
					#print stuff to output txt file
					trial_no=trial_no+1;	
					outputfile.print(trial_no);outputfile.print("\t"); #  Trial index from the beginning of the experiment is :((b-1)*40)+i
					outputfile.print(k);outputfile.print("\t"); 
					outputfile.print(i);outputfile.print("\t");
					#outputfile.print(blocks_FFfamiliar_array[k][i].filename());outputfile.print("\t");
					outputfile.print("FFfamiliar");outputfile.print("\t");		 
					outputfile.print("FFfamiliarTarget");outputfile.print("\t") ;
					outputfile.print(isi_jitter[i]);outputfile.print("\t");
					
					blocks_FFfamiliar_array[k][FFfamiliarOrder[i]].set_font(font_type[2]); ##set font type according to counterbalancing
					blocks_FFfamiliar_array[k][FFfamiliarOrder[i]].set_font_size(82);
					blocks_FFfamiliar_array[k][FFfamiliarOrder[i]].set_font_color(0,0,255);
					blocks_FFfamiliar_array[k][FFfamiliarOrder[i]].redraw();
					picStimulusColor.set_part(1, blocks_FFfamiliar_array[k][FFfamiliarOrder[i]]); 

					int stimOnset=clock.time()-t0;
					targetstimulus_trial.present();
					outputfile.print(stimOnset);outputfile.print("\t");outputfile.print("\n");					
					
				 elseif (targetPosition[i]==0) then 
					#term.print("else "); term.print("targ  "); term.print(targOccurrence);term.print("FFfamiliarOrder[i] ");term.print(letterOrder[i]); term.print("  "); term.print("r");term.print(r); term.print("  "); term.print("i");term.print(i);term.print("\n");
					blocks_FFfamiliar_array[k][FFfamiliarOrder[i]].set_font(font_type[2]); ##set font type according to counterbalancing
					blocks_FFfamiliar_array[k][FFfamiliarOrder[i]].set_font_size(82);
					blocks_FFfamiliar_array[k][FFfamiliarOrder[i]].set_font_color(0,0,0);								  
					blocks_FFfamiliar_array[k][FFfamiliarOrder[i]].redraw();
					picStimulus.set_part(1, blocks_FFfamiliar_array[k][FFfamiliarOrder[i]]); 
					eventStimulus.set_event_code(event_code_FFfamiliar);
					eventStimulus.set_target_button(0);
					eventStimulus.set_port_code(port_code_FFfamiliar);
					
					#print stuff to output txt file
					trial_no=trial_no+1;	
					outputfile.print(trial_no);outputfile.print("\t"); #  Trial index from the beginning of the experiment is :((b-1)*40)+i
					outputfile.print(k);outputfile.print("\t"); 
					outputfile.print(i);outputfile.print("\t");
					#outputfile.print(blocks_FFfamiliar_array[k][i].filename());outputfile.print("\t");
					outputfile.print("FFfamiliar");outputfile.print("\t");		 
					outputfile.print(blocks_FFfamiliar_array[k][FFfamiliarOrder[i]].caption());outputfile.print("\t") ;
					outputfile.print(isi_jitter[i]);outputfile.print("\t");
					

					#eventStimulus.set_response_active(true);
					int stimOnset=clock.time()-t0;
					stimulus_trial.present();
					outputfile.print(stimOnset);outputfile.print("\t");outputfile.print("\n");
					
				end;
				
				eventFixation.set_event_code(event_code_fixation);
				eventFixation.set_port_code(port_code_fixation);
				eventFixation.set_duration(isi_jitter[i]);
				eventFixation.set_response_active(true);
				fixation_trial.present();
				
				i=i+1
			end;

		#this is the rest (counterbalanced 3, 5, 7, 9 s - different order, but same time overall for each block)	
		#term.print("randISIRest"); term.print(randISIRest[k][j]);
		picRest.set_part(1, cross); 
		eventRest.set_event_code(event_code_rest);
		rest_trial.set_duration(randISIRest[k][j]); 
		eventRest.set_event_code(event_code_rest);
		rest_trial.present();

		#r=0;
		elseif (condition_order[j]=="N") then
		isi_jitter.shuffle();
		#----------------------
			if (targOccurrence==1) then
				targetPosition = {0,0,0,0,0,0,0,0,0,1};
				targetPosition.shuffle(3,10);
			elseif (targOccurrence == 2) then 
				targetPosition  = targetPosition2[k]
			else
				targetPosition = {0,0,0,0,0,0,0,0,0,0};
			end;
			term.print(targetPosition); term.print("\n");
		#--------------------------;
			#Same loop for new-condition
			loop int i=1 until i>10 begin;
				#if FFnewOrder[i] == 9 && targOccurrence==1 && r<1 then 
				if (targetPosition[i] == 1) then
					#term.print("if "); term.print("targ  "); term.print(targOccurrence);term.print("FFnewOrder[i] ");term.print(FFnewOrder[i]); term.print("  "); term.print("r");term.print(r); term.print("  "); term.print("i");term.print(i); term.print("\n");
					targEventStimulus.set_response_active(true);
					targEventStimulus.set_event_code(event_code_FFnew_targ);
					targEventStimulus.set_target_button(targButton);
					targEventStimulus.set_port_code(port_code_FFnew_targ);
					
					#print stuff to output txt file
					trial_no=trial_no+1;	
					outputfile.print(trial_no);outputfile.print("\t"); #  Trial index from the beginning of the experiment is :((b-1)*40)+i
					outputfile.print(k);outputfile.print("\t"); 
					outputfile.print(i);outputfile.print("\t");
					#outputfile.print(blocks_FFnew_array[k][i].filename());outputfile.print("\t");
					outputfile.print("FFnew");outputfile.print("\t");		 
					outputfile.print("FFnewTarget");outputfile.print("\t") ;
					outputfile.print(isi_jitter[i]);outputfile.print("\t");
					
					blocks_FFnew_array[k][FFnewOrder[i]].set_font(font_type[3]); ##set font type according to counterbalancing
					blocks_FFnew_array[k][FFnewOrder[i]].set_font_size(82);
					blocks_FFnew_array[k][FFnewOrder[i]].set_font_color(0,0,255);
					blocks_FFnew_array[k][FFnewOrder[i]].redraw();
					picStimulusColor.set_part(1, blocks_FFnew_array[k][FFnewOrder[i]]); 

					int stimOnset=clock.time()-t0;
					targetstimulus_trial.present();
					outputfile.print(stimOnset);outputfile.print("\t");outputfile.print("\n");

 				elseif (targetPosition[i]==0) then 
					#term.print("else"); term.print("targ  "); term.print(targOccurrence);term.print("FFnewOrder[i]");term.print(letterOrder[i]); term.print("  "); term.print("r");term.print(r); term.print("  "); term.print("i");term.print(i);term.print("\n");		
					blocks_FFnew_array[k][FFnewOrder[i]].set_font(font_type[3]); ##set font type according to counterbalancing
					blocks_FFnew_array[k][FFnewOrder[i]].set_font_size(82);
					blocks_FFnew_array[k][FFnewOrder[i]].set_font_color(0,0,0);											
					blocks_FFnew_array[k][FFnewOrder[i]].redraw();
					picStimulus.set_part(1, blocks_FFnew_array[k][FFnewOrder[i]]); 
					eventStimulus.set_event_code(event_code_FFnew);
					eventStimulus.set_target_button(0);
					eventStimulus.set_port_code(port_code_FFnew);
				
					#print stuff to output txt file
					trial_no=trial_no+1;	
					outputfile.print(trial_no);outputfile.print("\t"); #  Trial index from the beginning of the experiment is :((b-1)*40)+i
					outputfile.print(k);outputfile.print("\t"); 
					outputfile.print(i);outputfile.print("\t");
					#outputfile.print(blocks_FFnew_array[k][i].filename());outputfile.print("\t");
					outputfile.print("FFnew");outputfile.print("\t");		 
					outputfile.print(blocks_FFnew_array[k][FFnewOrder[i]].caption());outputfile.print("\t") ;
					outputfile.print(isi_jitter[i]);outputfile.print("\t");
					
					#eventStimulus.set_response_active(true);
					int stimOnset=clock.time()-t0;
					stimulus_trial.present();
					outputfile.print(stimOnset);outputfile.print("\t");outputfile.print("\n");
				end;
				
				eventFixation.set_event_code(event_code_fixation);
				eventFixation.set_port_code(port_code_fixation);
				eventFixation.set_duration(isi_jitter[i]);
				eventFixation.set_response_active(true);
				fixation_trial.present();
				
				i=i+1
			end;

		#this is the rest (counterbalanced 3, 5, 7, 9 s - different order, but same time overall for each block)	
		#term.print("randISIRest"); term.print(randISIRest[k][j]);
		picRest.set_part(1, cross); 
		eventRest.set_event_code(event_code_rest);
		rest_trial.set_duration(randISIRest[k][j]); 
		eventRest.set_event_code(event_code_rest);
		rest_trial.present();
		end;
		
		j=j+1;
	end; 
	k=k+1;
end;


event_wait_end.set_port_code(port_code_end);
wait_end.present();
#endTrial.present();