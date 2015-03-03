function display_swc_data_legacy(obj,event,handles,ai)
global swc; % properties etc
%global ai; %data aq. object

dat = peekdata(ai,ceil(ai.SampleRate/4));
%dat = peekdata(ai,event.Data.RelSample);


ylims=swc.ylims;
xt=linspace(0,swc.displaybuffersize,swc.displaybuffersize_samples);

if numel(dat)>0
    swc.displaybuffer=[swc.displaybuffer;dat];
    swc.displaybuffer = swc.displaybuffer(end-swc.displaybuffersize_samples+1:end,:);
    
    figure(1);
    clf; 
  %  cla(handles.main_plot);

    hold on;
   %  for i=1:floor(swc.displaybuffersize);
   %     plot([1 1]*i,ylims,'k','Color',[1 1 1].*.8);
   % end;
    
    subs=8; % subsample all but primary by this
    subs_primary=2;
    
    swc.gain_secondary;
    
    plot(xt(1:subs:end),swc.displaybuffer(1:subs:end,swc.chs.frame_trigger).*.5+10,'k','Color',[1 1 1].*.5);
    plot(xt(1:subs:end),swc.displaybuffer(1:subs:end,swc.chs.whisker_stim).*.5+10,'k','Color',[1 1 1].*.8);
    plot(xt(1:subs:end),swc.displaybuffer(1:subs:end,swc.chs.trial_trigger).*10-50,'k','Color',[1 1 1].*.4);
    
    
    primary=swc.displaybuffer(1:subs_primary:end,1)*swc.gain_primary;
    plot(xt(1:subs_primary:end),primary,'r');
    
    secondary = swc.displaybuffer(1:subs_primary:end,2)*swc.gain_secondary*2;
    plot(xt(1:subs_primary:end),secondary,'k');
    
    tsec=etime(clock,swc.tic);
    %text(0.1, -78,['session ',num2str(swc.session_nr),' recording nr. ',num2str(swc.recording_nr),'']);
    
    if get(handles.checkbox_autorange,'Value')==1
        ylim([min(primary)-10 max(primary)+10]);
    else
         if get(handles.checkbox_range_median,'Value')==1
            
             ylim([-50 50]+median(primary));
      
         else
        ylim(ylims);
         end;
    end;
    
    %compute bridge offset from 50Hz current pulses etc
    if get(handles.checkbox_bridgeoffs,'Value')==1 
        
        [B,A] = butter(2,([30 2000])./(swc.SampleRate/2));
        
        secondary_50=filter(B,A,secondary);
        primary_50=filter(B,A,primary);
        
        curr_in=range(quantile(secondary_50(end-2000:end),[.1 .9]));
        
        x=  primary_50(end-2000:end).*sign(secondary_50(end-2000:end));
        
        %volt_out=-quantile( abs(x)  ,[.9]) *sign(median(x));
        volt_out=-mean(x);
        
        bridge_offs=volt_out/curr_in;
        
        set(handles.slider_bridgeoffs,'Value',max(min(bridge_offs,.2),-.2));
        
        set(handles.text_bridgeoffs,'String',[num2str(bridge_offs),' Ohm']);
        %{
        if bridge_offs <0
            set(handles.slider_bridgeoffs,'BackgroundColor',[1 0 0]);
        else
            set(handles.slider_bridgeoffs,'BackgroundColor',[0 1 0]);
        end;
        %}
        if isnan(bridge_offs)
           bridge_offs=0
        end;
        
       
        
        b=.0001./((bridge_offs.^2)+.0001); % make middle blue for fine tuning
        bx=(1-b);
        a=(.5+tanh(bridge_offs*30)/2);
        
        % b=0;
        
        set(handles.slider_bridgeoffs,'BackgroundColor',[(1-a)*bx a*bx b]);
        
    end;
    
    
    
    %set(handles.main_plot,'Ylim',sort(ylims))
   set(gca, 'position', [0.015 0.02 1 1]);
     
set(handles.text_status,'String',[num2str(tsec),'s / ',num2str(round(tsec/60)),'min']); drawnow;

    drawnow;
end;

end