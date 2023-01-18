#!/bin/sh

flutter clean
cd shared/dependencies && flutter clean && flutter pub get && cd ../../
cd core && flutter clean && flutter pub get && cd ../
cd shared/component && flutter clean && flutter pub get && cd ../../
cd shared/flutter_device_id && flutter clean && flutter pub get && cd ../../
cd shared/l10n && flutter clean && flutter pub get && cd ../../
cd shared/preferences && flutter clean && flutter pub get && cd ../../
cd features/apps && flutter clean && flutter pub get && cd ../../
cd features/auth && flutter clean && flutter pub get && cd ../../
cd features/employee && flutter clean && flutter pub get && cd ../../
cd features/employee/attendance && flutter clean && flutter pub get && cd ../../../
cd features/employee/home && flutter clean && flutter pub get && cd ../../../
cd features/employee/leave && flutter clean && flutter pub get && cd ../../../
cd features/employee/notice && flutter clean && flutter pub get && cd ../../../
cd features/employee/payroll && flutter clean && flutter pub get && cd ../../../
cd features/employee/profile && flutter clean && flutter pub get && cd ../../../
cd features/employee/resign && flutter clean && flutter pub get && cd ../../../
flutter clean && flutter pub get