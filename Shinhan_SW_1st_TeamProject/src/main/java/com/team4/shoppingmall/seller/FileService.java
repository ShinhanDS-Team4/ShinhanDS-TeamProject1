package com.team4.shoppingmall.seller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class FileService {

	public List<String> getFileNames(String directoryPath, String prefix) {
		File directory = new File(directoryPath);
		List<String> fileNames = new ArrayList<>();

		if (directory.exists() && directory.isDirectory()) {
			File[] files = directory.listFiles();
			if (files != null) {
				for (File file : files) {
					if (file.isFile() && file.getName().startsWith(prefix)) {
						fileNames.add(file.getName());
					}
				}
			}
		}
		return fileNames;
	}
}
