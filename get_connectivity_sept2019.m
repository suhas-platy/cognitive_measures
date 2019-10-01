function cxn_mtx = get_connectivity_sept2019( fname, varargin )
% @brief extract connectivity matrix (mean or sem) or stats thereof (t value, p value)
   
% for stat's, tier1 changes is group 1, time = -1
% for stat's, tier2 changes is group 2, time = -1
% for stat's, Before changes is group -1, time = 1
% for stat's, After changes is group -1, time = 2

% tier1 before mean: get_connectivity_sept2019( fname,...
%                'group', 1, 'time', 1, 'band', 1, 'stat', 1, 'SRT2', 0 );   
% tier1 changes, t-value: get_connectivity_sept2019( fname,...
%                'group', 1, 'time', -1, 'band', 1, 'stat', 1, 'SRT2', 0 );   

   
    verbose = 1;
   
    group = []; % 1 or 2
    time = []; % 1 for before or 2 for after
    band = []; % 1 to 5
    stat = 1; % 1 for mean, 2 for sem; 3 for t value, 4 for p value
    SRT2 = 0; % SRT2 file has a slightly different structure
   
    % arguments
    for i = 1:2:length(varargin)
        Param = varargin{i};
        Value = varargin{i+1};
        if ~ischar(Param)
            error('Flag arguments must be strings')
        end
        Param = lower(Param);
        switch Param
           case 'verbose'
              verbose=Value;
           case 'group'
              group=Value;
           case 'time'
              time=Value;
           case 'band'
              band=Value;
           case 'stat'
              stat=Value;
           case 'srt2'
              SRT2=Value;     
           otherwise
              error(['Unknown input parameter ''' Param ''' ???'])
        end
    end
    
    if ( ~isempty( group ) && ~isempty( time ) )
       if ( group == 1 && time == 1 )
          group_time = 2; % Before is 2nd
       elseif ( group == 1 && time == 2 )
          group_time = 1; % After is 1st
       elseif ( group == 2 && time == 1 )
          group_time = 4; % Before is 2nd
       elseif ( group == 2 && time == 2 )
          group_time = 3; % After is 1st
       elseif ( group == 1 && time == -1 )
          group_time = 5;
       elseif ( group == 2 && time == -1 )
          group_time = 6;
       elseif ( group == -1 && time == 1 )
          group_time = 7;
       elseif ( group == -1 && time == 2 )
          group_time = 8;
       else
          str = sprintf( 'Unknown group and time pairing: group %d, time %d', group, time );
          error( [str] );
       end
    end
    
    if ( band < 1 || band > 5 )
       str = sprintf( 'Band should be in [1,5]' );
       error( [str] );
    end
    
    if ( stat < 1 || stat > 4 )
       str = sprintf( 'Stat should be in [1,4]' );
       error( [str] );
    end

    % load
    mt_check_filename( fname );
    if ( verbose >= 2 )
       disp( sprintf( 'loading file %s', fname ) );
    end
    data = load( fname );
    data = data.data;
    
    % parse
    % mean or sem
    if ( stat == 1 || stat == 2 )
       if ( ~SRT2 )
          cxn_mtx = data.connectivity.values.chunks.eeg_dDTF08.block.data; % 12x12x5x4x2
       else
          cxn_mtx = data.connectivity.values.values.chunks.eeg_dDTF08.block.data; % 12x12x5x4x2
       end
       
       if ( isempty( group ) && isempty( time ) && isempty( band ) )
          cxn_mtx = cxn_mtx( :, :, :, :, stat );
          return;
       else
           % if you get this error: Index in position 4 exceeds array bounds (must not exceed 4).
           % group_time probably means you want the t-vals and p-vals (stat should be 3 or 4)
          cxn_mtx = cxn_mtx( :, :, band, group_time, stat );
          return;
       end
       
    else % t value or p value; stat is 3, 4
       if ( group_time == 5 )
          cxn_mtx = data.connectivity.tier1.stats.chunks.eeg_dDTF08.block.data;
       elseif ( group_time == 6 )
          cxn_mtx = data.connectivity.tier2.stats.chunks.eeg_dDTF08.block.data;
       elseif ( group_time == 7 )
          cxn_mtx = data.connectivity.Before.stats.chunks.eeg_dDTF08.block.data;
       else
          cxn_mtx = data.connectivity.After.stats.chunks.eeg_dDTF08.block.data;
       end
       
       if ( stat == 4 ) % remove self connections
           for i = 1:12
               for b = 1:5
                  cxn_mtx(i,i,b,stat-2) = NaN;  % -2 makes index go from [3,4] to [1,2]
               end
           end
       end
       
       if ( isempty( band ) )
          cxn_mtx = cxn_mtx( :, :, :, stat-2 ); % -2 makes index go from [3,4] to [1,2]
          return;
       else
          cxn_mtx = cxn_mtx( :, :, band, stat-2 ); % -2 makes index go from [3,4] to [1,2]
       end
       
    end       
    
    