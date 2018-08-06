/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */

package com.liferay.portal.webcache;

import com.liferay.portal.kernel.cache.PortalCache;
import com.liferay.portal.kernel.cache.SingleVMPoolUtil;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.util.Time;
import com.liferay.portal.kernel.webcache.WebCacheException;
import com.liferay.portal.kernel.webcache.WebCacheItem;
import com.liferay.portal.kernel.webcache.WebCachePool;

/**
 * @author Brian Wing Shun Chan
 */
public class WebCachePoolImpl implements WebCachePool {

	@Override
	public void clear() {
		PortalCache<String, Object> portalCache = _getPortalCache();

		portalCache.removeAll();
	}

	@Override
	public Object get(String key, WebCacheItem wci) {
		PortalCache<String, Object> portalCache = _getPortalCache();

		Object obj = portalCache.get(key);

		if (obj != null) {
			return obj;
		}

		try {
			obj = wci.convert(key);

			if (obj == null) {
				return null;
			}

			int timeToLive = (int)(wci.getRefreshTime() / Time.SECOND);

			portalCache.put(key, obj, timeToLive);
		}
		catch (WebCacheException wce) {
			if (_log.isWarnEnabled()) {
				Throwable cause = wce.getCause();

				if (cause != null) {
					_log.warn(cause, cause);
				}
				else {
					_log.warn(wce, wce);
				}
			}
		}

		return obj;
	}

	@Override
	public void remove(String key) {
		PortalCache<String, Object> portalCache = _getPortalCache();

		portalCache.remove(key);
	}

	private PortalCache<String, Object> _getPortalCache() {
		if (_portalCache == null) {
			_portalCache = SingleVMPoolUtil.getPortalCache(_CACHE_NAME);
		}

		return _portalCache;
	}

	private static final String _CACHE_NAME = WebCachePool.class.getName();

	private static final Log _log = LogFactoryUtil.getLog(
		WebCachePoolImpl.class);

	private volatile PortalCache<String, Object> _portalCache;

}