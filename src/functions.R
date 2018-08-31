choose_position_set <- function(playerPosition){
  if(playerPosition == 'All'){
    dat <- ov
  }
  if(playerPosition == 'Quarterback'){
    dat <- qb
  }
  if(playerPosition == 'Running Back'){
    dat <- rb
  }
  if(playerPosition == 'Wide Reciever'){
    dat <- wr
  }
  if(playerPosition == 'Tight End'){
    dat <- te
  }
  if(playerPosition == 'Kicker'){
    dat <- kc
  }
  if(playerPosition == 'Defense'){
    dat <- dst
  }
  return(dat)
}

create_tier_seq <- function(dat, startTier, endTier){
  minTier <- min(startTier, length(levels(dat$Tier)))
  maxTier <- min(endTier, length(levels(dat$Tier)))
  tier_seq <- minTier:maxTier
  return(tier_seq)
}

choose_color_palette <- function(tier_seq){
  tier_len <- length(tier_seq)
  this_pal <- tol_pal[[tier_len]]
  return(this_pal)
}

reduce_to_tiers <- function(dat, tier_seq){
  dat <- dat[dat$Tier %in% tier_seq, ]
  dat$Tier <- droplevels(dat$Tier)
  return(dat)
}

reduce_to_available <- function(dat, pickedList){
  pickedCond <- dat$Name %in% pickedList
  dat <- dat[!pickedCond, ]
  dat$Name <- droplevels(dat$Name)
  dat$Tier <- droplevels(dat$Tier)
  return(dat)
}

top_k_summary <- function(dat, spreadType = 'StdDev', k = 1){
  
  dat <- dat[order(dat$Rank), ]
  topPlayersRow <- dat[1:k, ]
  topPlayersName <- topPlayersRow$Name
  topPlayersInd <- which(ov$Name %in% topPlayersName)
  if(spreadType == 'StdDev'){
    topPlayerSummary <- paste(ov[topPlayersInd, 'Name'], 
                              ov[topPlayersInd, 'Average'], 
                              '+-',
                              ov[topPlayersInd, 'StdDev'])
  }
  if(spreadType == 'Range'){
    topPlayerSummary <- paste(ov[topPlayersInd, 'Name'], 
                              ov[topPlayersInd, 'Average'], 
                              '+-',
                              ov[topPlayersInd, 'Worst'] - ov[topPlayersInd, 'Best'])
  }
  
  return(topPlayerSummary)
  
}

viz_function <- function(playerPosition, startTier, endTier, spreadType = 'StdDev', pickedList = NA){
  
  working_dat <- choose_position_set(playerPosition)
  
  tier_seq <- create_tier_seq(dat = working_dat, startTier, endTier)
  
  this_pal <- choose_color_palette(tier_seq)
  
  working_dat <- reduce_to_tiers(working_dat, tier_seq)
  
  working_dat <- reduce_to_available(working_dat, pickedList)

  
  if(spreadType == 'StdDev'){
    topPlayerSummary <- top_k_summary(working_dat, 'StdDev', 3)
    
    viz <- ggplot(working_dat, aes(Average, Rank)) +
      geom_segment(aes(x = Average - StdDev, xend = Average + StdDev, y = Rank, yend = Rank, col = Tier)) + 
      geom_point(aes(col = Tier), shape = 4) + 
      scale_y_reverse() + 
      geom_text(aes(label = Name, col = Tier), vjust = 1, hjust = 0) +
      scale_color_manual(name = 'Tier', values = this_pal) + 
      theme_hc() + xlab('Estimated Rank') + ylab('') + 
      ggtitle(topPlayerSummary[1])
  }
  if(spreadType == 'Range'){
    topPlayerSummary <- top_k_summary(working_dat, 'Range', 3)
    
    viz <- ggplot(working_dat, aes(Average, Rank)) +
      geom_segment(aes(x = Best, xend = Worst, y = Rank, yend = Rank, col = Tier)) +
      geom_point(aes(col = Tier), shape = 4) + 
      scale_y_reverse() + 
      geom_text(aes(label = Name, col = Tier), vjust = 1, hjust = 0) +
      scale_color_manual(name = 'Tier', values = this_pal) + 
      theme_hc() + xlab('Estimated Rank') + ylab('') + 
      ggtitle(topPlayerSummary[1])
  }
    
  return(viz)
}


calc_my_grade <- function(myPicks){
  if(is.null(myPicks)){stop('No pick yet')}
  pick_cond <- ov$Name %in% myPicks
  my_pick_df <- ov[pick_cond, ]
  total_rank <- sum(my_pick_df$Rank)
  total_picks <- nrow(my_pick_df)
  avg_rank <- total_rank / total_picks
  benchmark <- mean(1:(12 * total_picks))
  score <- avg_rank / benchmark
  grade <- NA
  if(score < .9){
    grade <- 'A'
  } else if(score < 1){
    grade <- 'B'
  } else if(score < 1.1){
    grade <- 'C'
  } else if(score < 1.2){
    grade <- 'D'
  } else {grade <- 'F'}
  return(grade)
}



