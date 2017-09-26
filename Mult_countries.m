% Interface for many countries

clc
close all
clear all

% Asking for parametres

table=input('USE_pur (write 1) or USE_bas (write 2)?\n');
write_xlsx=0; % Do you want information to be written into xlsx file (1 or 0)?
metrs_numb=6; % ammount of used metrics except N0
mtds_numb=3; % ammount of used methods

Data={};

source=input('Choose source of data: from xlsx file (1) or you will type (2)?\n');

if (source==1)
    
    filename=input('Write filename (without .xlsx):\n','s');
    filename=[filename,'.xlsx'];
    
    sheet=input('Write sheet number in xlsx file:\n');
    
    range=input('Write range where data is contained (ex: A6:H10):\n','s');
    
    [years, countries]=xlsread(filename,sheet,range);
    
    years = num2cell(years);
    
    Data = [countries years];
    
    Numb = size(years,1);
    
end;

if (source==2)
    flag=1;
    Numb = 0;
    while (flag==1)

        Numb=Numb+1;
        country=input('Write country name (3 letters):\n','s');

        base_year=input('Write base year (1995-2011):\n');

        target_year=input('Write target year (1995-2011):\n');

        Data(Numb,:) = {country,base_year,target_year};

        flag=input('Continue? (0 or 1)\n');

    end;
end;

if (table==1)
    table_text = 'USE_pur';
else
    table_text = 'USE_bas';
end;

filename = ['Results_',table_text,'_base_countries.xlsx'];
sheet1 = 'Results 1st qdt';
sheet2 = 'Results 2nd qdt';
sheet3 = 'Results 1&2 qdts';

info1 = {[table_text,' 1st quadrant']};
info2 = {[table_text,' 2nd quadrant']};
info3 = {[table_text,' 1st&2nd quadrants']};

xlswrite(filename,info1,sheet1,'A1');
xlswrite(filename,info2,sheet2,'A1');
xlswrite(filename,info3,sheet3,'A1');

string = 3;

table_pattern = {'Method\Metric','MAPE','R','SWAD','R','WAPE','R','PsiStat',...
    'R','RSQ','R','Inac','R','N0','R_all','CmR';...
    'GRAS',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;...
    'Kuroda1',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;...
    'INSD',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
% ...
%     'Kuroda2',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;...
%     'Kuroda3',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};

for i=1:Numb
    
    country = Data{i,1};
    base_year = Data{i,2};
    target_year = Data{i,3};

    %1st quadrant
    [GRAS_1,Kuroda1_1,INSD_1,Kuroda2_1,Kuroda3_1]...
    = Interface(country,table,1,base_year,target_year,write_xlsx);

    res_1 = [GRAS_1;Kuroda1_1;INSD_1];%;Kuroda2_1;Kuroda3_1];
    
    %2nd quadrant
    [GRAS_2,Kuroda1_2,INSD_2,Kuroda2_2,Kuroda3_2]...
    = Interface(country,table,2,base_year,target_year,write_xlsx);

    res_2 = [GRAS_2;Kuroda1_2;INSD_2];%;Kuroda2_2;Kuroda3_2];
    
    %1&2 quadrants
    [GRAS_3,Kuroda1_3,INSD_3,Kuroda2_3,Kuroda3_3]...
    = Interface(country,table,3,base_year,target_year,write_xlsx);

    res_3 = [GRAS_3;Kuroda1_3;INSD_3];%;Kuroda2_3;Kuroda3_3];
    
    %ranging results
    finres_1 = RangeMetrs(res_1,metrs_numb,mtds_numb);
    finres_2 = RangeMetrs(res_2,metrs_numb,mtds_numb);
    finres_3 = RangeMetrs(res_3,metrs_numb,mtds_numb);
    
    %writing in xlsx file
    curr_string = string + 10*(i-1);%change 10 to 10+k, if add k more methods
    curr_country = Data(i,1);
    curr_years = {[num2str(Data{i,2}),' -> ',num2str(Data{i,3})]};
    country_cell = ['A',num2str(curr_string)];
    years_cell = ['A',num2str(curr_string+2)];
    table_cell = ['A',num2str(curr_string+4)];
    tableRes_cell = ['B',num2str(curr_string+5)];
    
    xlswrite(filename,curr_country,sheet1,country_cell);
    xlswrite(filename,curr_years,sheet1,years_cell);
    xlswrite(filename,table_pattern,sheet1,table_cell);
    xlswrite(filename,finres_1,sheet1,tableRes_cell);
    
    xlswrite(filename,curr_country,sheet2,country_cell);
    xlswrite(filename,curr_years,sheet2,years_cell);
    xlswrite(filename,table_pattern,sheet2,table_cell);
    xlswrite(filename,finres_2,sheet2,tableRes_cell);
    
    xlswrite(filename,curr_country,sheet3,country_cell);
    xlswrite(filename,curr_years,sheet3,years_cell);
    xlswrite(filename,table_pattern,sheet3,table_cell);
    xlswrite(filename,finres_3,sheet3,tableRes_cell);

end;

disp(['More information you will find in the file: ',filename]);

