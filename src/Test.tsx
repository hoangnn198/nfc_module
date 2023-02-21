import * as React from "react";
import { Text, View, StyleSheet } from "react-native";

interface TestProps {}

const Test = (props: TestProps) => {
  return (
    <View style={styles.container}>
      <Text>Test</Text>
    </View>
  );
};

export default Test;

const styles = StyleSheet.create({
  container: {},
});
