import React, { useEffect } from "react";
import {
  Text,
  View,
  StyleSheet,
  SafeAreaView,
  StatusBar,
  NativeModules,
  Platform,
  NativeEventEmitter,
  Alert,
  BackHandler,
  TouchableOpacity,
  ViewStyle,
  TextStyle,
} from "react-native";
const { PostNFC, NFCModule } = NativeModules;
const NFCEvent = new NativeEventEmitter(NativeModules.NFCModule);

interface NFCProps {
  url: string;
  token: string;
  language: string;
  birthDate: string;
  outOfDate: string;
  citizenPid: string;
  checkBCA: boolean;
  styleBtn?: ViewStyle;
  styleText?: TextStyle;
}

const NFC = (props: NFCProps) => {
  const {
    url,
    token,
    language,
    birthDate,
    outOfDate,
    citizenPid,
    checkBCA,
    styleBtn,
    styleText,
  } = props;

  useEffect(() => {
    if (Platform.OS == "ios") {
      NFCEvent.addListener("NFCNotAvailable", (data) => {
        console.log("NFCNotAvailable", data);
      });
      NFCEvent.addListener("NFCSuccess", (data) => {
        console.log("NFCSuccess", data);
      });
      NFCEvent.addListener("NFCFail", (data) => {
        console.log("NFCFail", data);
        let text = "";
        text =
          language == "vi"
            ? "CCCD dùng cho xác thực NFC không đúng. Vui lòng thực hiện lại"
            : "The ID Card using for NFC verification is not correct. Please try again";
        Alert.alert(text);
      });
      NFCEvent.addListener("VerifySuccess", (data) => {
        let dataJSON = JSON.parse(data.data);
        console.log("dataJSON:::: ", dataJSON);
        return;
      });
      NFCEvent.addListener("VerifyFail", (data) => {
        console.log("VerifyFail", data);
      });
    }

    return () => {
      NFCEvent.removeAllListeners("NFCNotAvailable");
      NFCEvent.removeAllListeners("NFCSuccess");
      NFCEvent.removeAllListeners("NFCFail");
      NFCEvent.removeAllListeners("VerifySuccess");
      NFCEvent.removeAllListeners("VerifyFail");
    };
  }, []);

  const onPress = () => {
    console.log(url, token, birthDate, citizenPid);
    if (Platform.OS == "ios") {
      NFCModule.showNFC(
        url, //urrl
        token, //tokenNFC
        language, //language
        (birthDate), //namSinh
        (outOfDate), //ngayHetHan
        citizenPid, //soCCCD
        checkBCA // checkBCA
      );
    }
  };
  return (
    <View style={styles.container}>
      <TouchableOpacity
        onPress={() => onPress()}
        style={[
          styleBtn,
          {
            paddingVertical: 16,
            justifyContent: "center",
            alignItems: "center",
            backgroundColor: "#40A9FF",
            borderRadius: 8,
          },
        ]}
      >
        <Text style={[styleText, { color: "white", fontSize: 16 }]}>
          Check NFC
        </Text>
      </TouchableOpacity>
    </View>
  );
};

export { NFC } ;

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "white",
    justifyContent: "center",
    // alignItems: 'center',
    paddingHorizontal: 16,
  },
});
