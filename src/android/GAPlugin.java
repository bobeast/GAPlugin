package com.adobe.plugins;

import com.google.android.apps.analytics.GoogleAnalyticsTracker;

import org.apache.cordova.api.Plugin;
import org.apache.cordova.api.PluginResult;
import org.apache.cordova.api.PluginResult.Status;

import org.json.JSONArray;

public class GAPlugin extends Plugin {
    @Override
    public PluginResult execute(String action, JSONArray args, String callbackId) {
    	
    	GoogleAnalyticsTracker tracker = GoogleAnalyticsTracker.getInstance();
        PluginResult result = null;

        if (action.equals("initGA"))
        {
			try {
				tracker.startNewSession(args.getString(0), args.getInt(1), this.cordova.getActivity());
				result = new PluginResult(Status.OK, "initGA - id = "+args.getString(0)+"; interval = "+args.getInt(1)+" seconds");
			} catch (Exception e) {
				result = new PluginResult(Status.JSON_EXCEPTION);
			}
        }
        else if (action.equals("exitGA"))
        {
			try {
				tracker.stopSession();
				result = new PluginResult(Status.OK, "exitGA");
			} catch (Exception e) {
				result = new PluginResult(Status.JSON_EXCEPTION);
			}
        }
        else if (action.equals("trackEvent"))
        {
			try {
				tracker.trackEvent(args.getString(0), args.getString(1), args.getString(2), args.getInt(3));
				result = new PluginResult(Status.OK, "trackEvent - category = "+args.getString(0)+"; action = "+args.getString(1)+"; label = "+args.getString(2)+"; value = "+args.getInt(3));
			} catch (Exception e) {
				result = new PluginResult(Status.JSON_EXCEPTION);
			}
        }
        else if (action.equals("trackPage"))
        {
			try {
				tracker.trackPageView(args.getString(0));
				result = new PluginResult(Status.OK, "trackPage - url = "+args.getString(0));
			} catch (Exception e) {
				result = new PluginResult(Status.JSON_EXCEPTION);
			}
        }
        else if (action.equals("setVariable"))
        {
			try {
				tracker.setCustomVar(args.getInt(2), args.getString(0), args.getString(1));
				result = new PluginResult(Status.OK, "setVariable passed - index = "+ args.getInt(2)+"; key = "+args.getString(0)+"; value = "+args.getString(1));
			} catch (Exception e) {
				result = new PluginResult(Status.JSON_EXCEPTION);
			}
        }
        return result;
    }
 }
