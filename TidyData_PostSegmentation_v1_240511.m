 %240511_
 % Derived from OG file name:
 %TidyData_withinSegmentationCode_v8_230824B_edited230901_v3.m
 
% 240502 
% E ited from TidyDataData_withinSegmentationCode_v8_230824B_edited230901
%was unable to append 240502 as the edit data due to character limit in the
%name of a MATLAB file.
%Appended v2 instead.

%Old code
%----
% Edited from 230516(?) to run for supercoiling and linear DNA
% Edited from 230516(?) to run for supercoiling and linear DNA

% Edited from 230516(?) to run for supercoiling and linear DNA
%Compare with the original file (v7) - DNA state is muted for all DNAs
%Also 5kb switched off
% C1XY with 003C1XY


% filename = getfield (Amov,{1,1},'name')
% T_preserve{i} = readtable(filename,"VariableNamingRule","preserve")
% str = filename;
% str_trim = str(1:strfind(str,'.')-1)
% 
% EquivDia{i} = T_preserve{i}.EquivDiameter;
% px2um = 0.11;
% EquivDia_um{i} = EquivDia{i} * px2um;
% my_test_array = [EquivDia_um{i}];

my_test_array = EquivDia_um;
my_data = my_test_array;
test_data = my_data;
N_data = length(test_data);   

%test_data= dlmread(filename);
n_rows = size(test_data,1);
intermed_str = append(str_trim,'.'),
test_str = intermed_str

% if contains(intermed_str, 'II') == 1
%     test_str = erase(intermed_str,'II_')
% else 
%     test_str = intermed_str
% end 

%Case I -
%test_str_date = test_str(1:strfind(test_str,'_')-1);
%Case II - turn on
test_str_date = test_str(1:strfind(test_str,'_')-1);

str_fullfilname = test_str(1:strfind(test_str,'.'));
    
my_struct.Date = str2num(test_str_date);
my_struct.PolyP = 'P700';
my_struct.PolyPConc = 1; %mg/mL, final conc
my_struct.Buffer = 'HX'; %HEPES-NaOH
my_struct.IonicStrength = 50; %Units: mM,
my_struct.pH= 75; %Denotes pH 7.5∂
my_struct.SaltID= 'NS'; %NS:No Salt, Or for future NaCl, KCl
my_struct.SaltConc = 0; %SaltConc. in mM


%YOYO1 related
YOYO1_st_idx = strfind(str_fullfilname,'YOYO1')+6;
%YOYO1_end_idx = strfind(str_fullfilname,'YOYO1')+7;
%YOYO1_conc_search_value = test_str(YOYO1_st_idx:YOYO1_end_idx)
YOYO1_conc_search_value = test_str(YOYO1_st_idx)

if YOYO1_conc_search_value == '0'
    %my_struct.DNALabel = 'NL'; %YOYO1, YOYO3, or EndLabeled, use NL: for NoLabel - Code before 230824
    my_struct.DNALabel = 'YOYO1'; %YOYO1, YOYO3, or EndLabeled, use 0 for NoLabel/YOYO1 - Code after 230824
    my_struct.DNALabelConc = 0; %FinalConc: 1uM  %units uM; 0 for NoLabel
    %input('This one')

elseif YOYO1_conc_search_value == '1'
    %my_struct.DNALabel = 'NL'; %YOYO1, YOYO3, or EndLabeled, use NL: for NoLabel - Code before 230824
    my_struct.DNALabel = 'YOYO1'; %YOYO1, YOYO3, or EndLabeled, use 0 for NoLabel/YOYO1 - Code after 230824
    my_struct.DNALabelConc = 1; %FinalConc: 1uM  %units uM; 0 for NoLabel
    %input('Other one')

else
    %my_struct.DNALabel = 'NL'; %YOYO1, YOYO3, or EndLabeled, use NL: for NoLabel - Code before 230824
    my_struct.DNALabel = 'YOYO1'; %YOYO1, YOYO3, or EndLabeled, use 0 for NoLabel/YOYO1 - Code after 230824
    my_struct.DNALabelConc = 'Crazy'; %FinalConc: 1uM  %units uM; 0 for NoLabel
    %input('Error in assinging value')
end 

%DNA Concentration
%DNAconc_st_idx = strfind(str_fullfilname,'C1XY')-6;
DNAconc_st_idx = strfind(str_fullfilname,'C1XY')-6;
%DNAconc_en_idx = strfind(str_fullfilname,'ugmL');
DNAconc_en_idx = strfind(str_fullfilname,'C1XY')-5;
%DNAconc_search_value  =  test_str(DNAconc_st_idx+6:DNAconc_en_idx-1);
DNAconc_search_value  =  test_str(DNAconc_st_idx:DNAconc_en_idx);

if DNAconc_search_value=='_O'
    my_struct.DNAConc = 0; 
elseif DNAconc_search_value =='10'     %conc in ug/mL
    my_struct.DNAConc = 10 %conc in ug/mL
elseif DNAconc_search_value =='50'     %conc in ug/mL
    my_struct.DNAConc = 50 %conc in ug/mL
else 
    DNAconc_search_value = 'Error' %conc in ug/mL
end

     % else DNAconc_value = str2num(DNAconc_search_value)
     %    my_struct.DNAConc = DNAconc_value;
     % end



%DNA_st_idx = strfind(str_fullfilname,'Mg')-11;
%DNA_en_idx = strfind(str_fullfilname,'Mg')-1;
%DNA_search_value  =  test_str(DNA_st_idx:DNA_en_idx)


% DNA_st_idx = strfind(str_fullfilname,'kb')-2;
% DNA_en_idx = strfind(str_fullfilname,'kb')-1;
% DNA_search_value  =  test_str(DNA_st_idx:DNA_en_idx)
% DNA_search_value_num  =  str2num(DNA_search_value)
% 
% DNA_coil_state_st_idx = strfind(str_fullfilname,'kb')+3;
% DNA_coil_state_value  =  test_str(DNA_coil_state_st_idx)


DNA_st_idx = strfind(str_fullfilname,'C1XY')-13;
DNA_en_idx = strfind(str_fullfilname,'C1XY')-7;


%DNA_st_idx = strfind(str_fullfilname,'C1XY')-16;
%DNA_en_idx = strfind(str_fullfilname,'C1XY')-9;
DNA_search_value  =  test_str(DNA_st_idx:DNA_en_idx)

if contains(DNA_search_value,'NoDNA') ==1
    DNA_search_value_num = 0;
elseif contains (DNA_search_value,'pUC') == 1
    DNA_search_value_num = 2;

elseif contains (DNA_search_value,'CGA','IgnoreCase',true) == 1
    DNA_search_value_num = 990;
elseif contains (DNA_search_value,'OPT','IgnoreCase',true) == 1
    DNA_search_value_num = 991;
elseif contains (DNA_search_value,'mChr','IgnoreCase',true) == 1
    DNA_search_value_num = 992;

elseif contains (DNA_search_value,'15kb') == 1
    DNA_search_value_num = 15 
else
    DNA_search_value_num  =  str2num(DNA_search_value)
end 

% %Circular vs Linear
% DNA_coil_state_st_idx = strfind(str_fullfilname,'C1XY')-5;
% DNA_coil_state_value  =  test_str(DNA_coil_state_st_idx)
% 
% if contains(DNA_coil_state_value, 'L') == 1
%     my_struct.DNAState = 'L'
%     %elseif contains(test_str, 'Cir', 'IgnoreCase',true) == 1
% elseif contains(DNA_coil_state_value, 'C', 'IgnoreCase',true) == 1
%     my_struct.DNAState = 'C'
% else my_struct.DNAState = 'N' %Default case
%      %   usrinpt = input('C for Circular, L for Linear')
%      %        my_struct.DNAState = usrinpt
% %print('Using Default case No DNA')
% % 
% % input('Accept Default Case of No DNA : N')
%     input('Accept Default Case of No DNA : N')
%     input('Accept Default Case of No DNA : N')
% end

%No DNA vs Circular DNA
DNA_coil_state_st_idx = strfind(str_fullfilname,'C1XY')-12;
DNA_coil_state_end_idx = strfind(str_fullfilname,'C1XY')-5;
DNA_coil_state_value  =  test_str(DNA_coil_state_st_idx:DNA_coil_state_end_idx)

if contains(DNA_coil_state_value, 'NoDNA') == 1
    my_struct.DNAState = 'N'
    %elseif contains(test_str, 'Cir', 'IgnoreCase',true) == 1
else my_struct.DNAState = 'C' %Default case
     %   usrinpt = input('C for Circular, L for Linear')
     %        my_struct.DNAState = usrinpt
%print('Using Default case No DNA')
% 
% input('Accept Default Case of No DNA : N')
    input('Accept Default Case of circular DNA : C')
    input('Use N for default Case of No DNA : N')
end



% Acutal_Num_bp = [0; 2686; 5203; 7768; 9988; 15014; 20005; 24445; 30152; 48502; 166000]
    
if DNA_search_value_num == 0
    my_struct.DNAID = '0kb';
    my_struct.DNAbp = 0;
    my_struct.DNAConc = 0; %conc in ug/mL
    %my_struct.DNAState = 'N'; %'N','NLC': Not Linear or Circular (case of non DNA present),
%                          'C': Circular, 'L': Linear

elseif DNA_search_value_num == 2
    my_struct.DNAID = '2600b';
    my_struct.DNAbp = 2686;
    

elseif DNA_search_value_num == 990; %RCGA
    my_struct.DNAID = '5kbGC53RCGA10';
    my_struct.DNAbp = 5515;

elseif DNA_search_value_num == 991; %pOPT
    my_struct.DNAID = '5kbGC61pOPTO3';
    my_struct.DNAbp = 55150; %my_struct.DNAbp = 55150; Delibrating changing 
    % DNAbp to 55150 instead of 5515 to ensure distincition 
    % this will be fixed in Python code

elseif DNA_search_value_num == 992; %pOPT
    my_struct.DNAID = '5kbGC44pATmCh';
    my_struct.DNAbp = 5558; %my_struct.DNAbp = 55150; Delibrating changing 
    % DNAbp to 55150 instead of 5515 to ensure distincition 
    % this will be fixed in Python code 

   
%elseif contains(test_str, '111444') == 1
elseif DNA_search_value_num == 15
     my_struct.DNAID = '15kb';
     my_struct.DNAbp = 15014;
     my_struct.DNAConc = 10;
     %my_struct.DNAState = 'L-PCE'
    

elseif contains(test_str, 'NoDNA') == 1
    my_struct.DNAID = '0kb';
    my_struct.DNAbp = 0;
    my_struct.DNAConc = 0; %conc in ug/mL
    % my_struct.DNAState = 'N' % Default Circular 

else input('Error in Concentration assignment')
    %usrinpt = input('C for Circular, L for Linear')
    %my_struct.DNAState = usrinpt

end

%my_struct.DNAState = 'N'; 
%my_struct.DNALabel = 'NL'; %YOYO1, YOYO3, or EndLabeled, use NL: for NoLabel
%my_struct.DNALabelConc = 0; %FinalConc: 1uM  %units uM; 0 for NoLabel



my_struct.CationID = 'Mg';%Mg
my_struct.CationConc = 100 ;%FinalConc in mM
%my_struct.ExptID = 'II'; % Expt: 'I', 'II', 'III',

expt_st_idx = strfind(str_fullfilname,'_P700')-1;
expt_value  =  str2num(test_str(expt_st_idx))

if expt_value == 1
    my_struct.ExptID = 'I';
elseif expt_value == 2
    my_struct.ExptID = 'II';
elseif expt_value == 3
    my_struct.ExptID = 'III'
elseif expt_value == 4
    my_struct.ExptID = 'IV'
else
    my_struct.ExptID = 'Error'
end

fov_st_idx = strfind(str_fullfilname,'C1XY')+4;
%fov_ed_idx = strfind(str_fullfilname,'.')-1;

fov_ed_idx = strfind(str_fullfilname,'C1XY')+4;
fov_search_range  =  test_str(fov_st_idx:fov_ed_idx)

if contains(fov_search_range, 'All') == 1
    my_struct.FoV = 'X'; %FoV: 'X' for All          
else
    fov_search_range  =  test_str(fov_st_idx)
    if fov_search_range == '1'
        my_struct.FoV = 'I'
    elseif fov_search_range == '2'
        my_struct.FoV = 'II'
    elseif fov_search_range == '3'
        my_struct.FoV = 'III'
    elseif fov_search_range == '4'
        my_struct.FoV = 'IV'
    elseif fov_search_range == '5'
        my_struct.FoV = 'V'
    else input('Error in FoV')
    end

    %
    % my_struct.FoV = test_str(fov_st_idx:fov_st_idx);
end 

time_st_idx = strfind(str_fullfilname,'C1XY')-3;
time_ed_idx = time_st_idx +2;
time_value  =  test_str(time_st_idx:time_ed_idx)

if time_value == '004'
    my_struct.Time = 15; % 004: 15min
elseif time_value == '005'
    my_struct.Time = 20; % 005: 20min;
elseif time_value == '003'
    my_struct.Time = 10; % 003: 10min;
elseif time_value == '002'
    my_struct.Time = 5 %002: 5min;
else time_value == '001'
    my_struct.Time = 2; %001: 2min
end

my_testcell = struct2cell(my_struct);
x = cellfun(@num2str,my_testcell,'UniformOutput',false);
temp_filname = join(x,'_');
new_filname = char(temp_filname)

my_struct_rev = repmat(my_struct,n_rows,1);
my_array = test_data;
C = num2cell(my_array);
[my_struct_rev.Dia_um] = C{:};
my_tidyTable = struct2table(my_struct_rev,'AsArray',true);

%str_up = append(str_trim,'_propsTable')
%writetable(propsTable, str_up)

str = test_str;
%str_trim = str(1:strfind(str,'.')-11);
str_trim = str(1:strfind(str,'.')-1)
%mkdir([str_trim 'analysis'])
   
%mkdir([str_trim '_Analysis_TidyData'])
writetable(my_tidyTable,['./' str_trim 'analysis/' new_filname '.csv'],'Delimiter',',')
%CaseI - Default
%new_filname_trim = new_filname(1:strfind(new_filname,'Mg')+5)
%CaseII
new_filname_trim = new_filname(1:strfind(new_filname,'Mg')+5)

%mkdir(['../' new_filname_trim '/TidyData'])
mkdir(['../TidyData/' new_filname_trim])
writetable(my_tidyTable,['../TidyData/' new_filname_trim '/' new_filname '.csv'],'Delimiter',',')

%writematrix(EquivDiaCell_allData, ['../Average_V1/' str_trim_rev '_AllRoIs_um.txt'], 'delimiter','\t')

