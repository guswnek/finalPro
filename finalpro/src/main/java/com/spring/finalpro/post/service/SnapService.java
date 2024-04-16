package com.spring.finalpro.post.service;

import java.util.Map;

public interface SnapService {
	
	Map allBrandSnap();

	Map allStreetSnap();
	
	Map infoBrandSnap(String snapNo, String brand) ;

	int addViewSnap(String loginId, String snapNo);
}
